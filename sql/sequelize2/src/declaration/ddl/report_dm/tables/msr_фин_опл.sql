CREATE TABLE report_dm.msr_фин_опл (
	договор_ид int4 NULL,
	вид_реал_ид int4 NULL,
	дата timestamptz NULL,
	период_ид numeric(6, 2) NULL,
	док_нач_ид int4 NULL,
	опл_деб_без_аванса numeric NULL,
	опл_деб_аванс numeric NULL,
	опл_кред_перепл numeric NULL,
	опл_кред_аванс numeric NULL,
	погаш_деб_из_перепл numeric NULL,
	погаш_деб_из_аванс numeric NULL,
	опл_деб numeric NULL,
	опл_кред numeric NULL,
	погаш_деб_из_кред numeric NULL,
	обор_кред numeric NULL,
	погаш_деб numeric NULL,
	погаш_деб_без_аванса numeric NULL,
	опл numeric NULL
);

CREATE INDEX i_msr_фин_опл_договор_ид ON report_dm.msr_фин_опл USING btree(договор_ид);
CREATE INDEX i_msr_фин_опл_дата ON report_dm.msr_фин_опл USING btree(дата);
CREATE INDEX i_msr_фин_опл_договор_ид_дата ON report_dm.msr_фин_опл USING btree(договор_ид, дата);