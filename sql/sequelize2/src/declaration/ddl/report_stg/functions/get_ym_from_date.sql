CREATE OR REPLACE FUNCTION report_stg.get_ym_from_date(p_date DATE) RETURNS NUMERIC AS $$ BEGIN RETURN (
        (
            EXTRACT(
                YEAR
                FROM p_date
            ) + EXTRACT(
                MONTH
                FROM p_date
            ) / 100.0
        )
    );
END;
$$ LANGUAGE plpgsql;