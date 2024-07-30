CREATE OR REPLACE FUNCTION report_stg.fill_фин_опл () RETURNS VOID LANGUAGE plpgsql AS $$ 
BEGIN 
CREATE TEMP TABLE IF NOT EXISTS tmp ON COMMIT DROP AS
select o.kod_dog as договор_ид,
    o.kod_opl as опл_ид,
    o.vid_real AS вид_реал_ид,
    o.kod_type_opl as тип_опл_ид,
    o.kod_parent as исх_опл_ид,
    o.dat_uch as дата,
    o.ym AS период_ид,
    coalesce(o.opl, 0) + coalesce(o.opls, 0) as опл
from sr_opl o;
DELETE FROM report_stg.фин_опл;
INSERT INTO report_stg.фин_опл
SELECT *
FROM tmp;
END;
$$;