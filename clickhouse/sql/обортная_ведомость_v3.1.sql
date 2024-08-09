create table report_dev.test1 as 
with p as (
    select '2021-03-01'::date data_s,
        '2021-03-31'::date data_po
)
select a.dogovor_id,
sum(a.nachisl) nachisl,
sum(a.pogash_oplatoy) pogash_oplatoy,
sum(a.pogash_iz_kred) pogash_iz_kred,
sum(a.opl_kred_perepl) opl_kred_perepl,
sum(a.opl_kred_avans) opl_kred_avans,
sum(
    case
        when p.data_s between a.akt_s and a.akt_po then a.dolg_deb
    end
) dolg_deb_nach,
sum(
    case
        when p.data_s between akt_s and akt_po then dolg_kred
    end
) dolg_kred_nach,
sum(
    case
        when p.data_po between a.akt_s and a.akt_po then a.dolg_deb
    end
) dolg_deb_kon,
sum(
    case
        when p.data_po between akt_s and akt_po then dolg_kred
    end
) dolg_kred_kon
from msr_fin a
    join p on a.akt_s <= p.data_po
    and a.akt_po >= p.data_s
where a.vid_real_id = 2 
and a.akt_s <=  '2021-03-31':date
    and a.akt_po >= '2021-03-01'::date
group by a.dogovor_id