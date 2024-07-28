CREATE OR REPLACE FUNCTION report_stg.fill_фин_начисления() RETURNS VOID LANGUAGE plpgsql AS $$ BEGIN
DELETE FROM report_stg.фин_начисления;
INSERT INTO report_stg.фин_начисления (
        договор_ид,
        вид_реал_ид,
        док_нач_ид,
        вид_тов_ид,
        период_ид,
        дата,
        начислено
    )
SELECT fv.kod_dog договор_ид,
    fv.vid_real вид_реал_ид,
    fv.kod_sf док_нач_ид,
    fr.vid_t вид_тов_ид,
    fv.ym период_ид,
    fv.dat_sf дата,
    sum(fr.nachisl) as начислено
FROM sr_facras fr
    LEFT JOIN sr_facvip fv ON fr.kod_sf = fv.kod_sf
WHERE fv.vid_sf NOT IN (2, 9)
    AND fv.kod_dog IS NOT NULL
    -- AND kod_dog = 358
GROUP BY fv.kod_dog,
    fv.vid_real,
    fv.kod_sf,
    fr.vid_t,
    fv.ym;
END;
$$;