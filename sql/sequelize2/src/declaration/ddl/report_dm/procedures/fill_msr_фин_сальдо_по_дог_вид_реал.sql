CREATE OR REPLACE PROCEDURE report_dm.fill_msr_фин_сальдо_по_дог_вид_реал () LANGUAGE plpgsql AS $$ BEGIN
DELETE FROM report_dm.msr_фин_сальдо_по_дог_вид_реал;
INSERT INTO report_dm.msr_фин_сальдо_по_дог_вид_реал (
        договор_ид,
        вид_реал_ид,
        акт_с,
        акт_по,
        долг,
        долг_деб,
        долг_кред
    ) with x1 as (
        select a.дата,
            a.договор_ид,
            a.вид_реал_ид,
            sum(a.обор_деб) обор_деб,
            sum(a.обор_кред) обор_кред
        from report_dm.msr_фин_обор a
        group by a.дата,
            a.договор_ид,
            a.вид_реал_ид
    ),
    x2 as (
        select coalesce(
                (
                    LEAD(a.дата) OVER (
                        PARTITION BY a.договор_ид,
                        a.вид_реал_ид
                        ORDER BY a.дата
                    ) - INTERVAL '1 day'
                )::timestamptz,
                '2100-12-31'
            ) as акт_по,
            a.*
        from x1 a
    ),
    x3 as (
        select SUM(a.обор_кред) OVER (
                PARTITION BY a.договор_ид,
                a.вид_реал_ид
                ORDER BY a.дата
            ) as долг_кред,
            SUM(a.обор_деб) OVER (
                PARTITION BY a.договор_ид,
                a.вид_реал_ид
                ORDER BY a.дата
            ) as долг_деб,
            a.*
        from x2 a
    )
select a.договор_ид,
    a.вид_реал_ид,
    a.дата as акт_с,
    a.акт_по,
    coalesce(a.долг_деб, 0) - coalesce(a.долг_кред, 0) долг,
    a.долг_деб,
    a.долг_кред
from x3 a;
END;
$$;