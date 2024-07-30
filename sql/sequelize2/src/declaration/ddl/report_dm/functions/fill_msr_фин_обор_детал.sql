CREATE OR REPLACE FUNCTION report_dm.fill_msr_фин_обор_детал () RETURNS VOID LANGUAGE plpgsql AS $$ 
BEGIN 
DELETE FROM report_dm.msr_фин_обор_детал;
INSERT INTO report_dm.msr_фин_обор_детал
select a.договор_ид,
    a.вид_реал_ид,
    a.дата,
    a.период_ид,
    a.док_нач_ид,
    a.вид_тов_ид,
    a.начисл,
    null as опл_ид,
    null as тип_опл_ид,
    null as исх_опл_ид,
    null as опл
from report_stg.фин_начисл a
union ALL
select a.договор_ид,
    a.вид_реал_ид,
    a.дата,
    a.период_ид,
    null as док_нач_ид,
    null as вид_тов_ид,
    null as начисл,
    a.опл_ид,
    a.тип_опл_ид,
    a.исх_опл_ид,
    a.опл
from report_stg.фин_опл a;
END;
$$;