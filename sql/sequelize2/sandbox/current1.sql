select
    report_dm.fill_msr_фин_обор ();



select
    report_dm.fill_dim_дата ()

select
    report_dm.fill_all()

-- delete from report_stg.фин_начисления
select
    count(*)
from
report_dm.msr_фин_детал limit 100




select
    report_dm.fill_msr_фин_сальдо_по_дог ()

select count(*) from report_stg.фин_опл