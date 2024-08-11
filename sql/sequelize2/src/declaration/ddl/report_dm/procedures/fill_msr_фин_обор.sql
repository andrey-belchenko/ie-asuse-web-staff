CREATE OR REPLACE PROCEDURE report_dm.fill_msr_фин_обор () LANGUAGE plpgsql AS $$ BEGIN
DELETE FROM report_dm.msr_фин_обор a USING report_stg.refresh_slice rs
WHERE rs.договор_id = a.договор_id
    AND a.дата BETWEEN rs.дата_c AND rs.дата_по;
INSERT INTO report_dm.msr_фин_обор (
        refresh_slice_id,
        договор_id,
        вид_реал_id,
        дата,
        обор_деб,
        обор_кред
    ) with x1 as (
        select rs.refresh_slice_id,
            a.договор_id,
            a.вид_реал_id,
            a.дата,
            a.начисл,
            null::numeric погаш,
            null::numeric обор_кред
        from report_dm.msr_фин_начисл a
            JOIN report_stg.refresh_slice rs ON rs.договор_id = a.договор_id
            AND a.дата BETWEEN rs.период_с AND rs.период_по
        union all
        select rs.refresh_slice_id,
            a.договор_id,
            a.вид_реал_id,
            a.дата,
            null начисл,
            a.погаш,
            null обор_кред
        from report_dm.msr_фин_опл_погаш a
            JOIN report_stg.refresh_slice rs ON rs.договор_id = a.договор_id
            AND a.дата BETWEEN rs.период_с AND rs.период_по
        union all
        select rs.refresh_slice_id,
            a.договор_id,
            a.вид_реал_id,
            a.дата,
            null начисл,
            null погаш,
            a.обор_кред
        from report_dm.msr_фин_опл_кредит a
            JOIN report_stg.refresh_slice rs ON rs.договор_id = a.договор_id
            AND a.дата BETWEEN rs.период_с AND rs.период_по
    )
select a.refresh_slice_id,
    a.договор_id,
    a.вид_реал_id,
    a.дата,
    coalesce(sum(a.начисл), 0) - coalesce(sum(a.погаш), 0) обор_деб,
    sum(a.обор_кред) обор_кред
from x1 a
group by a.договор_id,
    a.вид_реал_id,
    a.дата;
commit;
END;
$$;