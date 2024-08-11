select * from report_dm.msr_фин_опл_погаш a join report_stg.refresh_slice s

on s.refresh_slice_id =  a.refresh_slice_id limit 1сс


select dep, count(*) from kr_dogovor  group by dep


select * from kr_org where kodp=1212