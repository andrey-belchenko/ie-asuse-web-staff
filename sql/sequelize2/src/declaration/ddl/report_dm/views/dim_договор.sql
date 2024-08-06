CREATE OR REPLACE VIEW report_dm.dim_договор AS
select kod_dog договор_ид,
    dep отделение_ид,
    ndog номер
from kr_dogovor;