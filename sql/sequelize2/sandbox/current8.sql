with x1 as (
    select a.договор_ид,
        case
            when a.тип_опл_ид in (2, 4) then 2
            else a.вид_реал_ид
        end as вид_реал_ид,
        a.дата,
        a.период_ид,
        a.док_нач_ид,
        a.опл_ид,
        a.тип_опл_ид,
        a.исх_опл_ид,
        a.опл,
        case
            when a.тип_опл_ид in (2, 4) then 1
            else 0
        end as пр_опл_ав_как_осн
    from report_stg.фин_опл a
    where a.тип_опл_ид in (0, 1, 2, 3, 4)
        and договор_ид = 358
    union ALL
    select a.договор_ид,
        a.вид_реал_ид,
        a.дата,
        a.период_ид,
        a.док_нач_ид,
        a.опл_ид,
        a.тип_опл_ид,
        a.исх_опл_ид,
        a.опл,
        0 as пр_опл_ав_как_осн
    from report_stg.фин_опл a
    where a.тип_опл_ид = 2
        and договор_ид = 358
),
x2 as (
    select a.*,
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
        end as погаш_деб_из_аванс
    from x1 a
),
x3 as (
    select a.*,
        coalesce(a.опл_деб_без_аванса, 0) + coalesce(a.опл_деб_аванс, 0) опл_деб,
        coalesce(a.опл_кред_перепл, 0) + coalesce(a.опл_кред_аванс, 0) опл_кред,
        coalesce(a.погаш_деб_из_перепл, 0) + coalesce(a.погаш_деб_из_аванс, 0) погаш_деб_из_кред,
        from x2 a
),
x4 as (
    select a.*,
        coalesce(a.опл_кред, 0) - coalesce(a.погаш_деб_из_кред, 0) обор_кред,
        coalesce(a.опл_деб, 0) + coalesce(a.погаш_деб_из_кред, 0) погаш_деб,
        coalesce(a.опл_деб_без_аванса, 0) + coalesce(a.погаш_деб_из_кред, 0) погаш_деб_без_аванса,
        coalesce(a.опл_деб, 0) + coalesce(a.опл_кред, 0) поступ_опл
    from x3 a
)
select договор_ид,
    вид_реал_ид,
    дата,
    период_ид,
    док_нач_ид,
    sum(опл_деб_без_аванса) опл_деб_без_аванса,
    sum(опл_деб_аванс) опл_деб_аванс,
    sum(опл_кред_перепл) опл_кред_перепл,
    sum(опл_кред_аванс) опл_кред_аванс,
    sum(погаш_деб_из_перепл) погаш_деб_из_перепл,
    sum(погаш_деб_из_аванс) погаш_деб_из_аванс,
    sum(опл_деб) опл_деб,
    sum(опл_кред) опл_кред,
    sum(погаш_деб_из_кред) погаш_деб_из_кред,
    sum(обор_кред) обор_кред,
    sum(погаш_деб) погаш_деб,
    sum(погаш_деб_без_аванса) погаш_деб_без_аванса,
    sum(поступ_опл) as опл
from x4
group by договор_ид,
    вид_реал_ид,
    дата,
    период_ид,
    док_нач_ид;