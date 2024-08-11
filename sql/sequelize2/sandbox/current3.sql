with prd as (
    select договор_id,
        (дата_c - INTERVAL '1 day')::date дата
    from report_stg.refresh_slice
),
oold as (
    select prd.дата,
        a.договор_id,
        a.вид_реал_id,
        a.долг_деб обор_деб,
        a.долг_кред обор_кред,
        a.долг обор
    from report_dm.msr_фин_сальдо_по_дог_вид_реал a
        JOIN prd ON prd.договор_id = a.договор_id
        AND prd.дата BETWEEN a.акт_с AND a.акт_по
),
onew as (
    select a.дата,
        a.договор_id,
        a.вид_реал_id,
        sum(a.обор_деб) обор_деб,
        sum(a.обор_кред) обор_кред,
        coalesce(sum(a.обор_деб), 0) - coalesce(sum(a.обор_кред), 0) обор
    from report_dm.msr_фин_обор a
        JOIN prd ON prd.договор_id = a.договор_id
        AND a.дата > prd.дата
    group by a.дата,
        a.договор_id,
        a.вид_реал_id
),
x1 as (
    select *
    from oold
    union all
    select *
    from onew
),
x2 as (
    select coalesce(
            (
                LEAD(a.дата) OVER (
                    PARTITION BY a.договор_id,
                    a.вид_реал_id
                    ORDER BY a.дата
                ) - INTERVAL '1 day'
            )::date,
            '2100-12-31'
        ) as акт_по,
        a.*
    from x1 a
),
x3 as (
    select SUM(a.обор_кред) OVER (
            PARTITION BY a.договор_id,
            a.вид_реал_id
            ORDER BY a.дата
        ) as долг_кред,
        SUM(a.обор_деб) OVER (
            PARTITION BY a.договор_id,
            a.вид_реал_id
            ORDER BY a.дата
        ) as долг_деб,
        SUM(a.обор) OVER (
            PARTITION BY a.договор_id,
            a.вид_реал_id
            ORDER BY a.дата
        ) as долг,
        a.*
    from x2 a
)
select a.договор_id,
    a.вид_реал_id,
    a.дата as акт_с,
    a.акт_по,
    a.долг,
    a.долг_деб,
    a.долг_кред
from x3 a
    JOIN prd ON prd.договор_id = a.договор_id
    AND a.дата > prd.дата
order by    акт_с desc 
    ;




--  select 
--  a.акт_с,
--         a.договор_id,
--         a.вид_реал_id,
--         a.долг_деб ,
--         a.долг_кред ,
--         a.долг обор
--     from report_dm.msr_фин_сальдо_по_дог_вид_реал a
--         where   a.договор_id=358 and вид_реал_id=2 order by акт_с desc