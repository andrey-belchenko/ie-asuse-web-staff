CREATE TABLE report_dm.msr_фин_детал (
    долг_осн_по_дог numeric NULL,
    долг_кред_по_дог numeric NULL,
    долг_по_дог numeric NULL,
    итог_по_дог_до timestamptz NULL,
    обор numeric NULL,
    обор_осн numeric NULL,
    обор_кред numeric NULL,
    начисл_осн numeric NULL,
    погаш_осн numeric NULL,
    опл_кред numeric NULL,
    сторно_кред numeric NULL,
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
    опл numeric NULL
);
CREATE INDEX msr_фин_детал_договор_ид ON report_dm.msr_фин_детал USING btree(договор_ид);
CREATE INDEX msr_фин_детал_дата ON report_dm.msr_фин_детал USING btree(дата);
CREATE INDEX msr_фин_детал_итог_по_дог_до ON report_dm.msr_фин_детал USING btree(итог_по_дог_до);