CREATE TABLE report_dm.msr_фин_обор_детал (
	договор_ид int4 NULL,
	вид_реал_ид int4 NULL,
	дата timestamptz NULL,
	период_ид numeric(6, 2) NULL,
	док_нач_ид int4 NULL,
	вид_тов_ид int4 NULL,
	начисл numeric NULL,
	опл_ид int4 NULL,
	тип_опл_ид int4 NULL,
	исх_опл_ид int4 NULL,
	опл numeric NULL
);

CREATE INDEX msr_фин_обор_детал_договор_ид  ON report_dm.msr_фин_обор_детал USING btree(договор_ид );
