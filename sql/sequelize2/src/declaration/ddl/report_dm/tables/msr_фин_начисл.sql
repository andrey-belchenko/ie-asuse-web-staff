CREATE TABLE report_dm.msr_фин_начисл (
	ид SERIAL,
	изменено TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	договор_ид int4,
	вид_реал_ид int4 NULL,
	дата date,
	док_нач_ид int4 NULL,
	вид_тов_ид int4 NULL,
	начисл numeric NULL
);
CREATE INDEX i_msr_фин_начисл_договор_ид ON report_dm.msr_фин_начисл USING btree(договор_ид);
CREATE INDEX i_msr_фин_начисл_дата ON report_dm.msr_фин_начисл USING btree(дата);
CREATE INDEX i_msr_фин_начисл_договор_ид_дата ON report_dm.msr_фин_начисл USING btree(договор_ид, дата);