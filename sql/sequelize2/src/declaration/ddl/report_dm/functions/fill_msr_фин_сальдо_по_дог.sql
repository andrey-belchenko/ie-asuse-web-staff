CREATE OR REPLACE FUNCTION report_dm.fill_msr_фин_сальдо_по_дог () RETURNS VOID LANGUAGE plpgsql AS $$ BEGIN
DELETE FROM report_dm.msr_фин_сальдо_по_дог;
INSERT INTO report_dm.msr_фин_сальдо_по_дог (
        договор_ид,
        акт_с,
        акт_по,
        долг_осн_деб,
        долг_осн_кред,
        долг_осн,
        долг,
        долг_деб
    ) with x1 as (
        select a.дата,
            a.договор_ид,
            sum(a.обор_осн_деб) обор_осн_деб,
            sum(a.обор_осн_кред) обор_осн_кред,
            sum(a.обор_осн) обор_осн,
            sum(a.обор) обор,
            sum(a.обор_деб) обор_деб
        from report_dm.msr_фин_обор a
        group by a.дата,
            a.договор_ид
    ),
    x2 as (
        select coalesce(
                (
                    LEAD(a.дата) OVER (
                        PARTITION BY a.договор_ид
                        ORDER BY a.дата
                    ) - INTERVAL '1 day'
                )::timestamptz,
                '9999-01-01'
            ) as акт_по,
            a.*
        from x1 a
    ),
    x3 as (
        select SUM(a.обор_осн_деб) OVER (
                PARTITION BY a.договор_ид
                ORDER BY a.дата
            ) as долг_осн_деб,
            SUM(a.обор_осн_кред) OVER (
                PARTITION BY a.договор_ид
                ORDER BY a.дата
            ) as долг_осн_кред,
            SUM(a.обор_осн) OVER (
                PARTITION BY a.договор_ид
                ORDER BY a.дата
            ) as долг_осн,
            SUM(a.обор) OVER (
                PARTITION BY a.договор_ид
                ORDER BY a.дата
            ) as долг,
            SUM(a.обор_деб) OVER (
                PARTITION BY a.договор_ид
                ORDER BY a.дата
            ) as долг_деб,
            a.*
        from x2 a
    )
select договор_ид,
    a.дата as акт_с,
    a.акт_по,
    a.долг_осн_деб,
    a.долг_осн_кред,
    a.долг_осн,
    a.долг,
    a.долг_деб
from x3 a;
END;
$$;