insert into ob_result with p as (
        select toDate('2021-03-01') data_s,
            toDate('2021-03-31') data_po
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
    cross join p
where a.vid_real_id = 2
    and a.akt_s <= toDate('2021-03-31')
    and a.akt_po >= toDate('2021-03-01')
group by a.dogovor_id