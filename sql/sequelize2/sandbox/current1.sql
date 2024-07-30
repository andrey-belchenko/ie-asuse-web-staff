select
    report_stg.fill_фин_начисл ()
delete from report_stg.фин_начисления
select
    count(*)
from
report_stg.фин_начисл limit 100