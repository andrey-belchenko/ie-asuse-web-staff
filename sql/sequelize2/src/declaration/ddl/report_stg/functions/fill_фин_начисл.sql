CREATE OR REPLACE FUNCTION report_stg.fill_фин_начисл () RETURNS VOID LANGUAGE plpgsql AS $$ 
BEGIN 
CREATE TEMP TABLE IF NOT EXISTS tmp ON COMMIT DROP AS
SELECT fv.kod_dog AS договор_ид,
  fv.vid_real AS вид_реал_ид,
  fv.kod_sf AS док_нач_ид,
  fr.vid_t AS вид_тов_ид,
  fv.ym AS период_ид,
  fv.dat_sf AS дата,
  sum(fr.nachisl) as начисл
FROM sr_facras fr
  LEFT JOIN sr_facvip fv ON fr.kod_sf = fv.kod_sf
WHERE fv.vid_sf NOT IN (2, 9)
  -- AND fv.kod_dog = 358
GROUP BY fv.kod_dog,
  fv.vid_real,
  fv.kod_sf,
  fr.vid_t,
  fv.ym;
DELETE FROM report_stg.фин_начисл;
INSERT INTO report_stg.фин_начисл
SELECT *
FROM tmp;
END;
$$;