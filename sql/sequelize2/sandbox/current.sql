create table report_dev.test2 as


select 

договор_ид,
sum(case when дата between '2022-11-01'::date and '2022-11-30'::date then начисл_осн end) начисл_осн,
sum(case when дата between '2022-11-01'::date and '2022-11-30'::date then погаш_осн end) погаш_осн,
sum(case when '2022-11-01'::date between дата and итог_по_дог_до then долг_по_дог end) долг_по_дог_нач,
sum(case when '2022-11-30'::date between дата and итог_по_дог_до then долг_по_дог end) долг_по_дог_кон
from report_dm.msr_фин_детал

where 
1=1
--and договор_ид =358 
--and дата between '2022-11-01'::date and '2022-11-30'::date
and итог_по_дог_до > '2022-10-31'::date
and дата <= '2022-11-30'::date 
group by договор_ид



select count(*) from report_dm.msr_фин_детал