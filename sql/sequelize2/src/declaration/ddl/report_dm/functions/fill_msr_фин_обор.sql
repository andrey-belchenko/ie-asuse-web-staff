CREATE OR REPLACE FUNCTION report_dm.fill_msr_фин_обор () RETURNS VOID LANGUAGE plpgsql AS $$ BEGIN
DELETE FROM report_dm.msr_фин_обор;
INSERT INTO report_dm.msr_фин_обор (
        договор_ид,
        вид_реал_ид,
        дата,
        период_ид,
        док_нач_ид,
        вид_тов_ид,
        опл_ид,
        тип_опл_ид,
        исх_опл_ид,
        начисл,
        опл,
        погаш,
        начисл_осн,
        погаш_осн,
        опл_кред,
        сторно_кред,
        обор,
        обор_деб,
        обор_осн_деб,
        обор_осн_кред,
        обор_осн
    ) with x1 as (
        select a.договор_ид,
            a.вид_реал_ид,
            a.дата,
            a.период_ид,
            a.док_нач_ид,
            a.вид_тов_ид,
            a.начисл,
            null as опл_ид,
            null as тип_опл_ид,
            null as исх_опл_ид,
            null as опл,
            0 as пр_опл_ав_как_осн
        from report_stg.фин_начисл a
        union ALL
        select a.договор_ид,
            case
                when a.тип_опл_ид in (2, 4) then 2
                else a.вид_реал_ид
            end as вид_реал_ид,
            a.дата,
            a.период_ид,
            a.док_нач_ид as док_нач_ид,
            null as вид_тов_ид,
            null as начисл,
            a.опл_ид,
            a.тип_опл_ид,
            a.исх_опл_ид,
            a.опл,
            case
                when a.тип_опл_ид in (2, 4) then 1
                else 0
            end as пр_опл_ав_как_осн
        from report_stg.фин_опл a
        union ALL
        select a.договор_ид,
            a.вид_реал_ид,
            a.дата,
            a.период_ид,
            a.док_нач_ид as док_нач_ид,
            null as вид_тов_ид,
            null as начисл,
            a.опл_ид,
            a.тип_опл_ид,
            a.исх_опл_ид,
            a.опл,
            0 as пр_опл_ав_как_осн
        from report_stg.фин_опл a
        where a.тип_опл_ид = 2
    ),
    x2 as (
        select a.*,
            -- case
            --     when вид_реал_ид = 2 then начисл
            -- end as начисл_осн,
            case
                when тип_опл_ид in (0) then опл
            end as опл_деб_без_аванса,
            case
                when тип_опл_ид in (2)
                and пр_опл_ав_как_осн = 0 then опл
            end as опл_деб_аванс,
            case
                when тип_опл_ид in (1) then опл
            end as опл_кред_перепл,
            case
                when тип_опл_ид in (2)
                and пр_опл_ав_как_осн = 1 then опл
            end as опл_кред_аванс,
            case
                when тип_опл_ид in (3) then опл
            end as погаш_деб_из_перепл,
            case
                when тип_опл_ид in (4) then опл
            end as погаш_деб_из_аванс,
            case
                when тип_опл_ид in (5) then опл
            end as сторно_кред_перепл,
            case
                when тип_опл_ид in (6) then опл
            end as сторно_кред_аванс,
            -- case
            --     when вид_реал_ид = 2
            --     and тип_опл_ид in (0, 3, 4) then опл
            -- end as погаш_осн,
            -- case
            --     when тип_опл_ид in (1, 2)
            --     and вид_реал_ид = 2 then опл
            -- end as опл_кред,
            -- case
            --     when тип_опл_ид in (5, 6)
            --     and вид_реал_ид = 2 then - опл
            -- end as сторно_кред
        from x1 a
    ),
    x2 as (
        select a.*,
            case
                when вид_реал_ид = 2 then начисл
            end as начисл_осн,
            case
                when тип_опл_ид in (0)
                and пр_опл_ав_как_осн = 0 then опл
            end as опл_деб,
            case
                when тип_опл_ид in (0, 2, 3, 4)
                and пр_опл_ав_как_осн = 0 then опл
            end as погаш_деб,
            case
                when вид_реал_ид = 2
                and тип_опл_ид in (0, 3, 4) then опл
            end as погаш_осн,
            case
                when тип_опл_ид in (1, 2)
                and вид_реал_ид = 2 then опл
            end as опл_кред,
            case
                when тип_опл_ид in (5, 6)
                and вид_реал_ид = 2 then - опл
            end as сторно_кред
        from x1 a
    ),
    x3 as (
        select a.*,
            coalesce(a.начисл, 0) - coalesce(a.погаш_сч, 0) обор_сч_деб,
            coalesce(a.начисл, 0) - coalesce(a.погаш_деб, 0) обор_деб,
            coalesce(a.начисл_осн, 0) - coalesce(a.погаш_осн, 0) обор_осн_деб,
            coalesce(a.опл_кред, 0) - coalesce(a.сторно_кред, 0) обор_осн_кред
        from x2 a
    ),
    x4 as (
        select a.*,
            coalesce(a.обор_деб, 0) - coalesce(a.обор_осн_кред, 0) обор,
            coalesce(a.обор_деб, 0) - coalesce(a.обор_осн_кред, 0) обор_сч,
            coalesce(a.обор_осн_деб, 0) - coalesce(a.обор_осн_кред, 0) обор_осн
        from x3 a
    )
select договор_ид,
    вид_реал_ид,
    дата,
    период_ид,
    док_нач_ид,
    вид_тов_ид,
    опл_ид,
    тип_опл_ид,
    исх_опл_ид,
    начисл,
    опл,
    погаш,
    начисл_осн,
    погаш_осн,
    опл_кред,
    сторно_кред,
    обор,
    обор_деб,
    обор_осн_деб,
    обор_осн_кред,
    обор_осн
from x4;
END;
$$;