select vid_real_id,
    sum(nachisl) nachisl
from report_dm.msr_fin a
where a.akt_s toDate('2021-03-01') and toDate('2021-03-31')
group by vid_real_id