CREATE TABLE report_dm.msr_фин_опл_погаш (
	ид SERIAL,
	опл_ид int4 NULL,
	договор_ид int4 NULL,
	вид_реал_ид int4 NULL,
	дата date,
	док_нач_ид int4 NULL,
	погаш_оплатой_без_аванса numeric NULL,
	погаш_оплатой_аванс numeric NULL,
	погаш_из_перепл numeric NULL,
	погаш_из_аванса numeric NULL,
	погаш_оплатой numeric NULL,
	погаш_из_кред numeric NULL,
	погаш numeric NULL,
	погаш_без_аванса numeric NULL
);

CREATE INDEX i_msr_фин_опл_погаш_договор_ид ON report_dm.msr_фин_опл_погаш USING btree(договор_ид);
CREATE INDEX i_msr_фин_опл_погаш_дата ON report_dm.msr_фин_опл_погаш USING btree(дата);
CREATE INDEX i_msr_фин_опл_погаш_договор_ид_дата ON report_dm.msr_фин_опл_погаш USING btree(договор_ид, дата);