CREATE OR REPLACE PROCEDURE report_stg.fill_фин_опл () LANGUAGE plpgsql AS $$ BEGIN
DELETE FROM report_stg.фин_опл;
INSERT INTO report_stg.фин_опл (
        договор_id,
        опл_id,
        вид_реал_id,
        тип_опл_id,
        исх_опл_id,
        док_нач_id,
        дата,
        период_id,
        опл
    )
select o.kod_dog as договор_id,
    o.kod_opl as опл_id,
    o.vid_real AS вид_реал_id,
    o.kod_type_opl as тип_опл_id,
    o.kod_parent as исх_опл_id,
    o.kod_sf as док_нач_id,
    o.dat_uch as дата,
    o.ym AS период_id,
    coalesce(o.opl, 0) + coalesce(o.opls, 0) as опл
from sr_opl o;
commit;
END;
$$;