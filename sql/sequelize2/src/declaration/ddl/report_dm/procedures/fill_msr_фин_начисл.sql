CREATE OR REPLACE PROCEDURE report_dm.fill_msr_фин_начисл () LANGUAGE plpgsql AS $$ BEGIN
DELETE FROM report_dm.msr_фин_начисл;
INSERT INTO report_dm.msr_фин_начисл (
        договор_ид,
        вид_реал_ид,
        дата,
        период_ид,
        док_нач_ид,
        вид_тов_ид,
        начисл
    )
select a.договор_ид,
    a.вид_реал_ид,
    a.дата,
    a.период_ид,
    a.док_нач_ид,
    a.вид_тов_ид,
    a.начисл
    from report_stg.фин_начисл a;
END;
$$;