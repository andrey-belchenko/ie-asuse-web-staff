CREATE OR REPLACE PROCEDURE report_dm.fill_all () LANGUAGE plpgsql AS $$ BEGIN 
call report_stg.fill_фин_начисл();
call report_stg.fill_фин_опл();
END;
$$;