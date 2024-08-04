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
from x1