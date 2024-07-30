begin;

delete from report_stg.фин_начисления;

insert into
    report_stg.фин_начисления (
        договор_ид,
        вид_реал_ид,
        док_нач_ид,
        вид_тов_ид,
        период_ид,
        дата,
        начислено
    )
SELECT
    fv.kod_dog договор_ид,
    fv.vid_real вид_реал_ид,
    fv.kod_sf док_нач_ид,
    fr.vid_t вид_тов_ид,
    fv.ym период_ид,
    fv.dat_sf дата,
    sum(fr.nachisl) as начислено
FROM
    sr_facras fr
    left join sr_facvip fv on fr.kod_sf = fv.kod_sf
where
    fv.vid_sf NOT IN (2, 9)
    and fv.kod_dog is NOT NULL
    and kod_dog = 358
group BY
    fv.kod_dog,
    fv.vid_real,
    fv.kod_sf,
    fr.vid_t,
    fv.ym;

end;