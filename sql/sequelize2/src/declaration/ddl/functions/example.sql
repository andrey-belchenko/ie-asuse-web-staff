CREATE OR REPLACE FUNCTION report_stg.example() RETURNS TABLE (kod_sf INT, kod_dog INT) AS $$ BEGIN RETURN QUERY
select a.kod_sf,
    a.kod_dog
from sr_facvip a;
END $$ LANGUAGE 'plpgsql';