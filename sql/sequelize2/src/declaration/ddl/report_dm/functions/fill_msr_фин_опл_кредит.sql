CREATE OR REPLACE FUNCTION report_dm.fill_msr_фин_опл_кредит () RETURNS VOID LANGUAGE plpgsql AS $$ BEGIN
DELETE FROM report_dm.msr_фин_опл_кредит;
INSERT INTO report_dm.msr_фин_опл_кредит (
        опл_ид,
        договор_ид,
        вид_реал_ид,
        дата,
        опл_кред_перепл,
        опл_кред_аванс,
        сторно_кред_перепл,
        обор_кред,
        опл_кред,
        сторно_кред
    ) with x1 as (
        select a.договор_ид,
            2 вид_реал_ид,
            a.дата,
            a.опл_ид,
            a.тип_опл_ид,
            a.опл
        from report_stg.фин_опл a
        where a.тип_опл_ид in (1, 2, 5, 6) --and договор_ид = 358
    ),
    x2 as (
        select a.*,
            case
                when тип_опл_ид in (1) then опл
            end as опл_кред_перепл,
            case
                when тип_опл_ид in (2) then опл
            end as опл_кред_аванс,
            case
                when тип_опл_ид in (5) then - опл
            end as сторно_кред_перепл,
            case
                when тип_опл_ид in (6) then - опл
            end as сторно_кред_аванс
        from x1 a
    ),
    x3 as (
        select a.*,
            coalesce(a.опл_кред_перепл, 0) + coalesce(a.опл_кред_аванс, 0) опл_кред,
            coalesce(a.сторно_кред_перепл, 0) + coalesce(a.сторно_кред_аванс, 0) сторно_кред
        from x2 a
    ),
    x4 as (
        select a.*,
            coalesce(a.опл_кред, 0) - coalesce(a.сторно_кред, 0) обор_кред
        from x3 a
    )
select опл_ид,
    договор_ид,
    вид_реал_ид,
    дата,
    sum(опл_кред_перепл) опл_кред_перепл,
    sum(опл_кред_аванс) опл_кред_аванс,
    sum(сторно_кред_перепл) сторно_кред_перепл,
    sum(обор_кред) обор_кред,
    sum(опл_кред) опл_кред,
    sum(сторно_кред) сторно_кред
from x4
group by опл_ид,
    договор_ид,
    вид_реал_ид,
    дата;
END;
$$;