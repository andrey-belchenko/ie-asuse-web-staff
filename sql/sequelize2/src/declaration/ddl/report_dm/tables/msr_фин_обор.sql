CREATE TABLE report_dm.msr_фин_обор (
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
	опл numeric NULL,
	начисл_осн numeric NULL,
	погаш_осн numeric NULL,
	опл_кред numeric NULL,
	сторно_кред numeric NULL,
	обор_осн_деб numeric NULL,
	обор_осн_кред numeric NULL,
	обор_осн numeric NULL
);
CREATE INDEX i_msr_фин_обор_договор_ид ON report_dm.msr_фин_обор USING btree(договор_ид);
CREATE INDEX i_msr_фин_обор_дата ON report_dm.msr_фин_обор USING btree(дата);