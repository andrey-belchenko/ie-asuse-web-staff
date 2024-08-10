CREATE TABLE report_dm.msr_фин_сальдо_по_дог (
    ид SERIAL,
    договор_ид int4 NULL,
    акт_с date,
    акт_по date,
    долг_осн_деб numeric NULL,
    долг_осн_кред numeric NULL,
    долг_осн numeric NULL,
    долг numeric NULL,
    долг_деб numeric NULL
);
CREATE INDEX i_msr_фин_сальдо_по_дог_договор_ид ON report_dm.msr_фин_сальдо_по_дог USING btree(договор_ид);
CREATE INDEX i_msr_фин_сальдо_по_дог_акт_с ON report_dm.msr_фин_сальдо_по_дог USING btree(акт_с);
CREATE INDEX i_msr_фин_сальдо_по_дог_акт_по ON report_dm.msr_фин_сальдо_по_дог USING btree(акт_по);