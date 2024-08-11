CREATE OR REPLACE PROCEDURE report_stg.fill_фин_начисл () LANGUAGE plpgsql AS $$ BEGIN
DELETE FROM report_stg.фин_начисл a USING report_stg.refresh_slice rs
WHERE rs.договор_id = a.договор_id
  AND a.дата BETWEEN rs.дата_c AND rs.дата_по;
INSERT INTO report_stg.фин_начисл (
    договор_id,
    вид_реал_id,
    док_нач_id,
    вид_тов_id,
    период_id,
    дата,
    начисл,
    refresh_slice_id
  )
SELECT fv.kod_dog AS договор_id,
  fv.vid_real AS вид_реал_id,
  fv.kod_sf AS док_нач_id,
  fr.vid_t AS вид_тов_id,
  fv.ym AS период_id,
  report_stg.get_last_date_of_ym(fv.ym) AS дата,
  sum(fr.nachisl) as начисл,
  max(rs.refresh_slice_id) refresh_slice_id
FROM sr_facras fr
  LEFT JOIN sr_facvip fv ON fr.kod_sf = fv.kod_sf
  JOIN report_stg.refresh_slice rs ON rs.договор_id = fv.kod_dog
  AND fv.ym BETWEEN rs.период_с AND rs.период_по
WHERE fv.vid_sf NOT IN (2, 9) 
GROUP BY fv.kod_dog,
  fv.vid_real,
  fv.kod_sf,
  fr.vid_t,
  fv.ym;
commit;
END;
$$;