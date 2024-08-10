CREATE TABLE report_dm.msr_фин (
    договор_ид int4 NULL,
    вид_реал_ид int4 NULL,
    дата date NULL,
    док_нач_ид int4 NULL,
    опл_ид int4 NULL,
    акт_с date NULL,
    акт_по date NULL,
    начисл numeric NULL,
    погаш_оплатой_без_аванса numeric NULL,
    погаш_оплатой_аванс numeric NULL,
    погаш_из_перепл numeric NULL,
    погаш_из_аванса numeric NULL,
    погаш_оплатой numeric NULL,
    погаш_из_кред numeric NULL,
    погаш numeric NULL,
    погаш_без_аванса numeric NULL,
    опл_кред_перепл numeric NULL,
    опл_кред_аванс numeric NULL,
    сторно_кред_перепл numeric NULL,
    обор_кред numeric NULL,
    опл_кред numeric NULL,
    сторно_кред numeric NULL,
    долг numeric NULL,
    долг_кред numeric NULL,
    долг_деб numeric NULL
);
CREATE INDEX i_msr_фин_договор_ид ON report_dm.msr_фин USING btree(договор_ид);
CREATE INDEX i_msr_фин_акт_с ON report_dm.msr_фин USING btree(акт_с);
CREATE INDEX i_msr_фин_акт_по ON report_dm.msr_фин USING btree(акт_по);
CREATE INDEX i_msr_фин_акт ON report_dm.msr_фин USING btree(акт_с, акт_по);