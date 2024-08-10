CREATE TABLE report_dm.msr_фин_обор (
	договор_ид int4 NULL,
	вид_реал_ид int4 NULL,
	дата date NULL,
	обор_деб numeric NULL,
	обор_кред numeric NULL
);
CREATE INDEX i_msr_фин_обор_договор_ид ON report_dm.msr_фин_обор USING btree(договор_ид);
CREATE INDEX i_msr_фин_обор_дата ON report_dm.msr_фин_обор USING btree(дата);
CREATE INDEX i_msr_фин_обор_договор_ид_дата ON report_dm.msr_фин_обор USING btree(договор_ид, дата);