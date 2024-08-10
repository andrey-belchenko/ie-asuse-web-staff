CREATE OR REPLACE FUNCTION report_dm.fill_all () RETURNS VOID LANGUAGE plpgsql AS $$ BEGIN perform report_dm.fill_dim_дата ();
perform report_dm.fill_msr_фин_обор ();
perform report_dm.fill_msr_фин_сальдо_по_дог ();
END;
$$;