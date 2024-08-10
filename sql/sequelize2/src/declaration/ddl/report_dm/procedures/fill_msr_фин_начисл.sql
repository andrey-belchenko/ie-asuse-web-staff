CREATE OR REPLACE PROCEDURE report_dm.fill_msr_фин_начисл () LANGUAGE plpgsql AS $$ BEGIN
DELETE FROM report_dm.msr_фин_начисл;
INSERT INTO report_dm.msr_фин_начисл (
        договор_id,
        вид_реал_id,
        дата,
        док_нач_id,
        вид_тов_id,
        начисл
    )
select a.договор_id,
    a.вид_реал_id,
    a.дата,
    a.док_нач_id,
    a.вид_тов_id,
    a.начисл
from report_stg.фин_начисл a;
commit;
END;
$$;