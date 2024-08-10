select vid_real_id,
    sum(nachisl) nachisl
from msr_fin a
where a.akt_s between toDate('2021-03-01') and toDate('2021-03-31')
group by vid_real_id




select count(*) from msr_fin


select count(*)
from msr_fin a
where a.akt_s between toDate('2021-05-01') and toDate('2021-05-31')
group by vid_real_id