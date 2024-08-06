CREATE OR REPLACE VIEW report_dm.dim_отделение AS
select o.kodp отделение_ид,
    o.name наименование
from kr_org o
where exists (
        select *
        from kr_dogovor d
        where d.dep = o.kodp
    );