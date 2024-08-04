drop table if EXISTS report_dev.test2;
create table report_dev.test2 as with x1 as (
    select договор_ид,
        начисл_осн,
        погаш_осн,
        опл_кред,
        сторно_кред
    from report_dm.msr_фин_обор
    where дата between '2022-11-01'::date and '2022-11-30'::date -- and договор_ид = 358
),
x2 as (
    select договор_ид,
        case
            when '2022-11-01'::date between акт_с and акт_по then долг_осн
        end долг_осн_нач,
        case
            when '2022-11-30'::date between акт_с and акт_по then долг_осн
        end долг_осн_кон
    from report_dm.msr_фин_сальдо_по_дог
    where акт_с <= '2022-11-30'::date
        and акт_по > '2022-10-31'::date -- and договор_ид = 358
),
x3 as (
    select договор_ид,
        начисл_осн,
        погаш_осн,
        опл_кред,
        сторно_кред,
        null as долг_осн_нач,
        null as долг_осн_кон
    from x1
    union ALL
    select договор_ид,
        null as начисл_осн,
        null as погаш_осн,
        null as опл_кред,
        null as сторно_кред,
        долг_осн_нач,
        долг_осн_кон
    from x2
),
x4 as (
    select договор_ид,
        sum(начисл_осн) начисл_осн,
        sum(погаш_осн) погаш_осн,
        sum(опл_кред) опл_кред,
        sum(сторно_кред) сторно_кред,
        sum(долг_осн_нач) долг_осн_нач,
        sum(долг_осн_кон) долг_осн_кон
    from x3
    group by договор_ид
)
select *
from x4;


select * from report_dev.test2