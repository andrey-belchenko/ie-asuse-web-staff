drop table report_dev.draft;
create table report_dev.draft as
SELECT fv.kod_dog договор_ид,
    fv.vid_real вид_реал_ид,
    fv.kod_sf док_нач_ид,
    fr.vid_t вид_тов_ид,
    fv.ym период_ид,
    fv.dat_sf дата,
    sum(fr.nachisl) as начислено
FROM sr_facras fr
    left join sr_facvip fv on fr.kod_sf = fv.kod_sf
where fv.vid_sf NOT IN (2, 9)
    and fv.kod_dog is NOT NULL
    and kod_dog = 358
group BY fv.kod_dog,
    fv.vid_real,
    fv.kod_sf,
    fr.vid_t,
    fv.ym -- limit 5 
    --     <call function="if" as="dat_rep" type="date" comment="59495 " dimension="dat">
    --   <call function="and">
    --     <call function="lt">
    --       <call function="date to ym">
    --         <column table="this" column="dat_sf" />
    --       </call>
    --       <column table="this" column="ym" />
    --     </call>
    --     <call function="!=">
    --       <column table="this" column="vid_real" />
    --       <const>0</const>
    --     </call>
    --   </call>
    --   <call function="ym end day">
    --     <column table="this" column="ym" />
    --   </call>
    --   <column table="this" column="dat_sf" />
    -- </call>