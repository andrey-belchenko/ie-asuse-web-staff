CREATE OR REPLACE PROCEDURE report_stg.fill_фин_начисл () LANGUAGE plpgsql AS $$ BEGIN CREATE TEMP TABLE IF NOT EXISTS tmp ON COMMIT DROP AS
SELECT fv.kod_dog AS договор_id,
  fv.vid_real AS вид_реал_id,
  fv.kod_sf AS док_нач_id,
  fr.vid_t AS вид_тов_id,
  fv.ym AS период_id,
  report_stg.get_ym_last_date(fv.ym) AS дата,
  sum(fr.nachisl) as начисл
FROM sr_facras fr
  LEFT JOIN sr_facvip fv ON fr.kod_sf = fv.kod_sf
WHERE fv.vid_sf NOT IN (2, 9) -- AND fv.kod_dog = 358
GROUP BY fv.kod_dog,
  fv.vid_real,
  fv.kod_sf,
  fr.vid_t,
  fv.ym;
DELETE FROM report_stg.фин_начисл;
INSERT INTO report_stg.фин_начисл (
    договор_id,
    вид_реал_id,
    док_нач_id,
    вид_тов_id,
    период_id,
    дата,
    начисл
  )
SELECT *
FROM tmp;
commit;
END;
$$;