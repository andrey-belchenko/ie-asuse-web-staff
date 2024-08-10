CREATE OR REPLACE PROCEDURE report_dm.fill_msr_фин_обор () LANGUAGE plpgsql AS $$ BEGIN
DELETE FROM report_dm.msr_фин_обор;
INSERT INTO report_dm.msr_фин_обор (
        договор_id,
        вид_реал_id,
        дата,
        обор_деб,
        обор_кред
    ) with x1 as (
        select a.договор_id,
            a.вид_реал_id,
            a.дата,
            a.начисл,
            null::numeric погаш,
            null::numeric обор_кред
        from report_dm.msr_фин_начисл a
        union all
        select a.договор_id,
            a.вид_реал_id,
            a.дата,
            null начисл,
            a.погаш,
            null обор_кред
        from report_dm.msr_фин_опл_погаш a
        union all
        select a.договор_id,
            a.вид_реал_id,
            a.дата,
            null начисл,
            null погаш,
            a.обор_кред
        from report_dm.msr_фин_опл_кредит a
    )
select a.договор_id,
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