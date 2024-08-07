CREATE TABLE report_stg.фин_опл (
	договор_ид int4 NULL,
	опл_ид int4 NULL,
	вид_реал_ид int4 NULL,
	тип_опл_ид int4 NULL,
	исх_опл_ид int4 NULL,
	док_нач_ид int4 NULL,
	дата timestamptz NULL,
	период_ид numeric(6, 2) NULL,
	опл numeric NULL
);

CREATE INDEX фин_опл_договор_ид  ON report_stg.фин_опл USING btree(договор_ид );