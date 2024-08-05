CREATE TABLE report_dm.msr_фин_сальдо_по_дог_вид_реал (
    договор_ид int4 NULL,
    вид_реал_ид int4 NULL,
    акт_с timestamptz NULL,
    акт_по timestamptz NULL,
    долг numeric NULL,
    долг_кред numeric NULL,
    долг_деб numeric NULL
);
CREATE INDEX i_msr_фин_сальдо_по_дог_вид_реал_договор_ид ON report_dm.msr_фин_сальдо_по_дог_вид_реал USING btree(договор_ид);
CREATE INDEX i_msr_фин_сальдо_по_дог_вид_реал_акт_с ON report_dm.msr_фин_сальдо_по_дог_вид_реал USING btree(акт_с);
CREATE INDEX i_msr_фин_сальдо_по_дог_вид_реал_акт_по ON report_dm.msr_фин_сальдо_по_дог_вид_реал USING btree(акт_по);