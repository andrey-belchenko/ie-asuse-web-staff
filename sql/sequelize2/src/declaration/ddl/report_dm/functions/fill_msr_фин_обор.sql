CREATE OR REPLACE FUNCTION report_dm.fill_msr_фин_обор () RETURNS VOID LANGUAGE plpgsql AS $$ BEGIN
DELETE FROM report_dm.msr_фин_обор;
INSERT INTO report_dm.msr_фин_обор (
        договор_ид,
        вид_реал_ид,
        дата,
        период_ид,
        док_нач_ид,
        вид_тов_ид,
        начисл,
        опл_ид,
        тип_опл_ид,
        исх_опл_ид,
        опл,
        начисл_осн,
        погаш_осн,
        опл_кред,
        сторно_кред,
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
            null as опл
        from report_stg.фин_начисл a
        union ALL
        select a.договор_ид,
            a.вид_реал_ид,
            a.дата,
            a.период_ид,
            null as док_нач_ид,
            null as вид_тов_ид,
            null as начисл,
            a.опл_ид,
            a.тип_опл_ид,
            a.исх_опл_ид,
            a.опл
        from report_stg.фин_опл a
    ),
    x2 as (
        select a.*,
            case
                when вид_реал_ид = 2 then начисл
            end as начисл_осн,
            case
                when вид_реал_ид = 2
                and тип_опл_ид in (0, 3, 4) then опл
            end as погаш_осн,
            case
                when тип_опл_ид in (1, 2) then опл
            end as опл_кред,
            case
                when тип_опл_ид in (5, 6) then - опл
            end as сторно_кред
        from x1 a
    ),
    x3 as (
        select a.*,
            coalesce(a.начисл_осн, 0) - coalesce(a.погаш_осн, 0) обор_осн_деб,
            coalesce(a.опл_кред, 0) - coalesce(a.сторно_кред, 0) обор_осн_кред
            from x2 a
    ),
    x4 as (
        select a.*,
            coalesce(a.обор_осн_деб, 0) - coalesce(a.обор_осн_кред, 0) обор_осн
            from x3 a
    )
select договор_ид,
    вид_реал_ид,
    дата,
    период_ид,
    док_нач_ид,
    вид_тов_ид,
    начисл,
    опл_ид,
    тип_опл_ид,
    исх_опл_ид,
    опл,
    начисл_осн,
    погаш_осн,
    опл_кред,
    сторно_кред,
    обор_осн_деб,
    обор_осн_кред,
    обор_осн
    from x4;
END;
$$;