with a as (
    SELECT d.ndog,
        d.dep,
        d.kod_dog,
        fv.ym,
        fr.nachisl
    FROM sr_facras fr
        left join sr_facvip fv on fr.kod_sf = fv.kod_sf
        left join kr_dogovor d on fv.kod_dog = d.kod_dog
    --where fv.ym between 2022.01 and 2022.12
        and fv.vid_real = 2
)
select a.ndog,
    a.kod_dog,
    max(a.dep) dep,
    sum(a.nachisl) nachisl,
    min (a.ym) as ym_min,
    max(a.ym) as ym_max
from a
where ndog = '0018 Э'
group by a.ndog,
    a.kod_dog