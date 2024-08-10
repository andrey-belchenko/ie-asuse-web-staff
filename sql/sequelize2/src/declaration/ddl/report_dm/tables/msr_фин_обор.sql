CREATE TABLE report_dm.msr_фин_обор (
	id SERIAL,
	изменено TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	договор_id int4,
	вид_реал_id int4 NULL,
	дата date,
	обор_деб numeric NULL,
	обор_кред numeric NULL
);
CREATE INDEX i_msr_фин_обор_договор_id ON report_dm.msr_фин_обор USING btree(договор_id);
CREATE INDEX i_msr_фин_обор_дата ON report_dm.msr_фин_обор USING btree(дата);
CREATE INDEX i_msr_фин_обор_договор_id_дата ON report_dm.msr_фин_обор USING btree(договор_id, дата);