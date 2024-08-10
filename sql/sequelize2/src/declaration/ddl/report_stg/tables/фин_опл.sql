CREATE TABLE report_stg.фин_опл (
	id SERIAL,
	изменено TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	договор_id int4 NULL,
	опл_id int4 NULL,
	вид_реал_id int4 NULL,
	тип_опл_id int4 NULL,
	исх_опл_id int4 NULL,
	док_нач_id int4 NULL,
	дата date NULL,
	период_id numeric(6, 2) NULL,
	опл numeric NULL
);

CREATE INDEX фин_опл_договор_id  ON report_stg.фин_опл USING btree(договор_id );