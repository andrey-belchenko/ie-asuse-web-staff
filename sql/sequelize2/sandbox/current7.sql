with n as (
    select a.договор_ид,
        a.вид_реал_ид,
        a.вид_тов_ид,
        p.год,
        p.месяц,
        3 as порядок,
        sum(a.начисл) сумма
    from report_dm.msr_фин_обор a
        join report_dev.период p on a.дата between p.дата_с and p.дата_по
        and p.договор_ид = a.договор_ид
    where a.начисл is not null
        and p.год = 2019
        and p.месяц = 1
    group by a.договор_ид,
        a.вид_реал_ид,
        a.вид_тов_ид,
        p.год,
        p.месяц
),
o as (
    select a.договор_ид,
        a.вид_реал_ид,
        a.тип_опл_ид,
        p.год,
        p.месяц,
        sum(a.опл) сумма
    from report_dm.msr_фин_обор a
        join report_dev.период p on a.дата between p.дата_с and p.дата_по
        and p.договор_ид = a.договор_ид
    where p.год = 2019
        and p.месяц = 1
        and a.тип_опл_ид in (0, 1, 2, 3, 4)
    group by a.договор_ид,
        a.вид_реал_ид,
        a.тип_опл_ид,
        p.год,
        p.месяц
),
o1 as (
    select a.договор_ид,
        2 as вид_реал_ид,
        case
            a.тип_опл_ид
            when 1 then 74
            when 2 then 75
        end as вид_тов_ид,
        a.год,
        a.месяц,
        2 as порядок,
        sum(a.сумма) сумма
    from o a
    where a.тип_опл_ид in (1, 2)
    group by a.договор_ид,
        a.тип_опл_ид,
        a.год,
        a.месяц
),
o2 as (
    select 'Оплачено' as имя_стр,
        a.договор_ид,
        a.вид_реал_ид,
        a.год,
        a.месяц,
        3 as порядок,
        sum(a.сумма) сумма
    from o a
    where a.тип_опл_ид in (0, 2)
    group by a.договор_ид,
        a.вид_реал_ид,
        a.год,
        a.месяц
),
o3 as (
    select 'Погашение факта' as имя_стр,
        a.договор_ид,
        2 as вид_реал_ид,
        a.год,
        a.месяц,
        4 as порядок,
        sum(a.сумма) сумма
    from o a
    where a.тип_опл_ид in (3, 4)
    group by a.договор_ид,
        a.год,
        a.месяц
),
x as (
    select a.договор_ид,
        a.год,
        a.месяц,
        a.вид_реал_ид,
        a.вид_тов_ид,
        null as имя_стр,
        a.порядок,
        a.сумма
    from n a
    UNION ALL
    select a.договор_ид,
        a.год,
        a.месяц,
        a.вид_реал_ид,
        a.вид_тов_ид,
        null as имя_стр,
        a.порядок,
        a.сумма
    from o1 a
    UNION ALL
    select a.договор_ид,
        a.год,
        a.месяц,
        a.вид_реал_ид,
        null as вид_тов_ид,
        a.имя_стр,
        a.порядок,
        a.сумма
    from o2 a
    UNION ALL
    select a.договор_ид,
        a.год,
        a.месяц,
        a.вид_реал_ид,
        null as вид_тов_ид,
        a.имя_стр,
        a.порядок,
        a.сумма
    from o3 a
),
sn as (
    select a.договор_ид,
        p.год,
        p.месяц,
        sum(долг_осн) сумма
    from report_dm.msr_фин_сальдо_по_дог a
        join report_dev.период p on p.дата_с between a.акт_с and a.акт_по
        and p.договор_ид = a.договор_ид
    group by a.договор_ид,
        p.год,
        p.месяц
)
select *
from sn