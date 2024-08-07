CREATE TABLE report_stg.фин_начисл (
  договор_ид int4 NULL,
  вид_реал_ид int4 NULL,
  док_нач_ид int4 NULL,
  вид_тов_ид int4 NULL,
  период_ид numeric(6, 2) NULL,
  дата timestamptz NULL,
  начисл numeric NULL
);

CREATE INDEX фин_начисл_договор_ид  ON report_stg.фин_начисл USING btree(договор_ид );
