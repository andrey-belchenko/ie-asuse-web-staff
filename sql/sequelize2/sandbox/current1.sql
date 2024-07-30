select
    report_dm.fill_msr_фин_обор_детал ()



-- delete from report_stg.фин_начисления
select
    count(*)
from
report_dm.msr_фин_обор_детал limit 100




select
    report_stg.fill_фин_опл ()

select count(*) from report_stg.фин_опл