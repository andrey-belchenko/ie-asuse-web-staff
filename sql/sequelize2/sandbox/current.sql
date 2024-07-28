create table reporting.st_sr_facras as
SELECT fv.kod_dog,
    fv.vid_real,
    fv.kod_sf,
    fr.vid_t,
    fv.ym,
    fv.dat_sf,
    sum(fr.nachisl) as nachisl
FROM sr_facras fr
    left join sr_facvip fv on fr.kod_sf = fv.kod_sf
where fv.vid_sf NOT IN (2, 9)
    and fv.kod_dog is NOT NULL
group BY fv.kod_dog,
    fv.vid_real,
    fv.kod_sf,
    fr.vid_t,
    fv.ym
-- limit 5 
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