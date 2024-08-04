with d as (
    select год,
        месяц,
        min(дата) дата_нач,
        max(дата) дата_кон
    from report_dm.dim_дата
    where год = 2022
    GROUP BY год,
        месяц
),
x1 as (
    select a.договор_ид,
        d.год,
        d.месяц,
        sum(
            case
                when d.дата_нач between a.акт_с and a.акт_по then долг_осн
            end
        ) долг_осн_нач,
        sum(
            case
                when d.дата_кон between a.акт_с and a.акт_по then долг_осн
            end
        ) долг_осн_кон
    from report_dm.msr_фин_сальдо_по_дог a
        cross join d
    where a.договор_ид = 358
    group by a.договор_ид,
        d.год,
        d.месяц
)
select *
from x1;
select a.договор_ид,
    a.вид_тов_ид,
    d.год,
    d.месяц,
    sum(a.начисл) начисл
from report_dm.msr_фин_обор a
    left join report_dm.dim_дата d on d.дата = a.дата
where a.договор_ид = 358
    and a.дата between '2022-01-01'::date and '2022-12-31'::date --and a.вид_реал_ид = 2
group by a.договор_ид,
    a.вид_тов_ид,
    d.год,
    d.месяц
ORDER by d.год,
    d.месяц;
-- CREATE TEMP TABLE период ON COMMIT DROP AS with x1 
CREATE TEMP TABLE период ON COMMIT DROP AS with x1 as (
    SELECT a.договор_ид,
        min(a.дата) дата_с,
        max(a.дата) дата_по
    from report_dm.msr_фин_обор a
    where a.договор_ид in (358)
    group by a.договор_ид
)
select a.договор_ид,
    d.год,
    d.месяц,
    min(d.дата) дата_с,
    max(d.дата) дата_по
from x1 a
    join report_dm.dim_дата d on d.дата between a.дата_с and a.дата_по
group by a.договор_ид,
    d.год,
    d.месяц;



with o as (
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
), o1 as (
    select 'Оплачено' as имя_стр,
        a.договор_ид,
        a.вид_реал_ид,
        a.год,
        a.месяц,
        sum(a.сумма) сумма
    from o a
    group by a.договор_ид,
        a.вид_реал_ид,
        a.год,
        a.месяц
)
select *
from o1;


-- select * from sk_type_opl
select a.договор_ид,
    a.вид_реал_ид,
    a.вид_тов_ид,
    p.год,
    p.месяц,
    sum(a.начисл) начисл
from report_dm.msr_фин_обор a
    join report_dev.период p on a.дата between p.дата_с and p.дата_по
    and p.договор_ид = a.договор_ид
where a.начисл is not null
group by a.договор_ид,
    a.вид_реал_ид,
    a.вид_тов_ид,
    p.год,
    p.месяц
ORDER by p.год,
    p.месяц;