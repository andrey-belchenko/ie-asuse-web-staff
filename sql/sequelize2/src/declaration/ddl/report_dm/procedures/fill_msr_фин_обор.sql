CREATE OR REPLACE FUNCTION report_dm.fill_msr_фин_обор () RETURNS VOID LANGUAGE plpgsql AS $$ BEGIN
DELETE FROM report_dm.msr_фин_обор;
INSERT INTO report_dm.msr_фин_обор (
        договор_ид,
        вид_реал_ид,
        дата,
        обор_деб,
        обор_кред
    ) with x1 as (
        select a.договор_ид,
            a.вид_реал_ид,
            a.дата,
            a.начисл,
            null::numeric  погаш,
            null::numeric  обор_кред
        from report_dm.msr_фин_начисл a
        union all
        select a.договор_ид,
            a.вид_реал_ид,
            a.дата,
            null начисл,
            a.погаш,
            null обор_кред
        from report_dm.msr_фин_опл_погаш a
        union all
        select a.договор_ид,
            a.вид_реал_ид,
            a.дата,
            null начисл,
            null погаш,
            a.обор_кред
        from report_dm.msr_фин_опл_кредит a
    )
select a.договор_ид,
    a.вид_реал_ид,
    a.дата,
    coalesce(sum(a.начисл), 0) - coalesce(sum(a.погаш), 0) обор_деб,
    sum(a.обор_кред) обор_кред
from x1 a
group by a.договор_ид,
    a.вид_реал_ид,
    a.дата;
END;
$$;