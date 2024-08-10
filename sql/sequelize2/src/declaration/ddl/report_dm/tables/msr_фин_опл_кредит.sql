CREATE TABLE report_dm.msr_фин_опл_кредит (
	опл_ид int4 NULL,
	договор_ид int4 NULL,
	вид_реал_ид int4 NULL,
	дата date NULL,
	опл_кред_перепл numeric NULL,
	опл_кред_аванс numeric NULL,
	сторно_кред_перепл numeric NULL,
	обор_кред numeric NULL,
	опл_кред numeric NULL,
	сторно_кред numeric NULL
);

CREATE INDEX i_msr_фин_опл_кредит_договор_ид ON report_dm.msr_фин_опл_кредит USING btree(договор_ид);
CREATE INDEX i_msr_фин_опл_кредит_дата ON report_dm.msr_фин_опл_кредит USING btree(дата);
CREATE INDEX i_msr_фин_опл_кредит_договор_ид_дата ON report_dm.msr_фин_опл_кредит USING btree(договор_ид, дата);