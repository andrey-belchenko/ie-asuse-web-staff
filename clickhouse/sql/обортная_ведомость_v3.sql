create table report_dev.test1 as 
with p as (
    select toDate('2021-03-01') data_s,
        toDate('2021-03-31') data_po
),
p_otd as (
    select *
    from report_dm.dim_otdelenie
)
select a.dogovor_id,
max(o.naimenovanie) otdelenie_naimenovanie,
max(d.nomer) dogovor_nomer,
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
from report_dm.msr_fin a
    join p on a.akt_s <= p.data_po
    and a.akt_po >= p.data_s
    left join report_dm.dim_dogovor d on d.dogovor_id = a.dogovor_id
    join p_otd po on d.otdelenie_id = po.otdelenie_id
    left join report_dm.dim_otdelenie o on d.otdelenie_id = o.otdelenie_id
where a.vid_real_id = 2 
and a.akt_s <=  toDate('2021-03-31')
    and a.akt_po >= toDate('2021-03-01')
group by a.dogovor_id