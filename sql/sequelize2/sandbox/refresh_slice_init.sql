
delete from report_stg.refresh_slice

select * from report_stg.refresh_slice

insert into report_stg.refresh_slice(договор_id, дата_c, дата_по) values (358,'2000-01-01','3000-01-01')



insert into report_stg.refresh_slice (договор_id, дата_c, дата_по)
select kod_dog , '2022-03-01'::date, '2022-03-31'::date from kr_dogovor;



insert into report_stg.refresh_slice (договор_id, дата_c, дата_по)
select kod_dog , '1900-01-01'::date, '3000-01-01'::date from kr_dogovor;


ANALYZE report_stg.refresh_slice;

select count(*) from report_stg.refresh_slice