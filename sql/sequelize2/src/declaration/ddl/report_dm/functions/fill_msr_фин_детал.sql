CREATE OR REPLACE FUNCTION report_dm.fill_msr_фин_детал () RETURNS VOID LANGUAGE plpgsql AS $$ 
BEGIN 
DELETE FROM report_dm.msr_фин_детал;
INSERT INTO report_dm.msr_фин_детал
with x1 as (
    select case
            when вид_реал_ид = 2 then начисл
        end as начисл_осн,
        case
            when вид_реал_ид = 2
            and тип_опл_ид in (0, 3, 4) then опл
        end as погаш_осн,
        case
            when тип_опл_ид in (1, 2) then опл
        end as опл_кред,
        case
            when тип_опл_ид in (5, 6) then - опл
        end as сторно_кред,
        a.*
    from report_dm.msr_фин_обор_детал a
),
x2 as (
    select
        coalesce(a.начисл_осн, 0) - coalesce(a.погаш_осн, 0) обор_осн,
        coalesce(a.опл_кред, 0) - coalesce(a.сторно_кред, 0) обор_кред,
        a.*
    from x1 a
),
x3 as (
    select coalesce(a.обор_осн, 0) - coalesce(a.обор_кред, 0) обор,
        a.*
    from x2 a
),
x4 as (
    select coalesce(
            (
                LEAD(дата) OVER (
                    PARTITION BY договор_ид
                    ORDER BY дата
                ) - INTERVAL '1 day'
            )::timestamptz,
            '9999-01-01'
        ) as итог_по_дог_до,
        a.*
    from x3 a
),
x5 as (
    select case
            when a.дата <= a.итог_по_дог_до then SUM(a.обор_осн) OVER (
                PARTITION BY договор_ид
                ORDER BY дата
            )
        end as долг_осн_по_дог,
        case
            when a.дата <= a.итог_по_дог_до then SUM(a.обор_кред) OVER (
                PARTITION BY договор_ид
                ORDER BY дата
            )
        end as долг_кред_по_дог,
        case
            when a.дата <= a.итог_по_дог_до then SUM(a.обор) OVER (
                PARTITION BY договор_ид
                ORDER BY дата
            )
        end as долг_по_дог,
        a.*
    from x4 a
)
select *
from x5 a;
END;
$$;