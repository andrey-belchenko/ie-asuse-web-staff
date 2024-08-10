CREATE OR REPLACE PROCEDURE report_stg.fill_фин_опл () LANGUAGE plpgsql AS $$ BEGIN
DELETE FROM report_stg.фин_опл;
INSERT INTO report_stg.фин_опл
select o.kod_dog as договор_ид,
    o.kod_opl as опл_ид,
    o.vid_real AS вид_реал_ид,
    o.kod_type_opl as тип_опл_ид,
    o.kod_parent as исх_опл_ид,
    o.kod_sf as док_нач_ид,
    o.dat_uch as дата,
    o.ym AS период_ид,
    coalesce(o.opl, 0) + coalesce(o.opls, 0) as опл
from sr_opl o;
commit;
END;
$$;