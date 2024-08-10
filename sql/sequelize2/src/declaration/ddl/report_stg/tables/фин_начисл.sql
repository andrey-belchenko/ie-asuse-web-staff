CREATE TABLE report_stg.фин_начисл (
  id SERIAL,
  изменено TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  договор_id int4 NULL,
  вид_реал_id int4 NULL,
  док_нач_id int4 NULL,
  вид_тов_id int4 NULL,
  период_id numeric(6, 2) NULL,
  дата date NULL,
  начисл numeric NULL
);

CREATE INDEX фин_начисл_договор_id  ON report_stg.фин_начисл USING btree(договор_id );
