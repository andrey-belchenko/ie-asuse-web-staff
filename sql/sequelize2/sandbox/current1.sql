select
    report_stg.fill_фин_начисления ()
delete from report_stg.фин_начисления
select
    *
from
report_stg.фин_начисления limit 100