CREATE OR REPLACE FUNCTION report_util.get_лицевая_карта(p_дата_с date, p_дата_по date, отделение_ид integer) RETURNS TABLE (
        строка text,
        договор_ид int4,
        год int4,
        месяц int4,
        вид_реал_ид int4,
        порядок int8,
        сумма numeric
    ) LANGUAGE plpgsql AS $$ BEGIN CREATE TEMP TABLE период ON COMMIT DROP AS with x1 as (
        SELECT a.договор_ид,
            min(a.дата) дата_с,
            max(a.дата) дата_по
        from report_dm.msr_фин_обор a
        where a.договор_ид in (
                SELECT unnest(p_договор_ид)
            )
        group by a.договор_ид
    )
select a.договор_ид,
    d.год,
    d.месяц,
    min(d.дата) дата_с,
    max(d.дата) дата_по
from x1 a
    join report_dm.dim_дата d on d.дата between a.дата_с and a.дата_по
group by a.договор_ид,
    d.год,
    d.месяц;
CREATE TEMP TABLE result ON COMMIT DROP AS with n as (
    select a.договор_ид,
        a.вид_реал_ид,
        a.вид_тов_ид,
        p.год,
        p.месяц,
        2 as порядок,
        sum(a.начисл) сумма
    from report_dm.msr_фин_начисл a
        join период p on a.дата between p.дата_с and p.дата_по
        and p.договор_ид = a.договор_ид
    group by a.договор_ид,
        a.вид_реал_ид,
        a.вид_тов_ид,
        p.год,
        p.месяц
),
ok as (
    select a.договор_ид,
        p.год,
        p.месяц,
        2 вид_реал_ид,
        sum(a.опл_кред_перепл) опл_кред_перепл,
        sum(a.опл_кред_аванс) опл_кред_аванс
    from report_dm.msr_фин_опл_кредит a
        join период p on a.дата between p.дата_с and p.дата_по
        and p.договор_ид = a.договор_ид
    group by a.договор_ид,
        p.год,
        p.месяц
),
o1 as (
    select a.договор_ид,
        74 as вид_тов_ид,
        a.год,
        a.месяц,
        a.вид_реал_ид,
        2 as порядок,
        a.опл_кред_перепл сумма
    from ok a
    where опл_кред_перепл != 0
),
o2 as (
    select a.договор_ид,
        75 as вид_тов_ид,
        a.год,
        a.месяц,
        a.вид_реал_ид,
        2 as порядок,
        a.опл_кред_аванс сумма
    from ok a
    where опл_кред_аванс != 0
),
op as (
    select a.договор_ид,
        a.вид_реал_ид,
        p.год,
        p.месяц,
        sum(a.погаш_оплатой) погаш_оплатой,
        sum(a.погаш_из_кред) погаш_из_кред
    from report_dm.msr_фин_опл_погаш a
        join период p on a.дата between p.дата_с and p.дата_по
        and p.договор_ид = a.договор_ид
    group by a.договор_ид,
        a.вид_реал_ид,
        p.год,
        p.месяц
),
o3 as (
    select 'Оплачено' as имя_стр,
        a.договор_ид,
        a.вид_реал_ид,
        a.год,
        a.месяц,
        3 as порядок,
        a.погаш_оплатой сумма
    from op a
    where погаш_оплатой != 0
),
o4 as (
    select 'Погашение факта' as имя_стр,
        a.договор_ид,
        a.вид_реал_ид,
        a.год,
        a.месяц,
        4 as порядок,
        a.погаш_из_кред сумма
    from op a
    where погаш_из_кред != 0
),
sn as (
    select 'Начальное сальдо' as имя_стр,
        a.договор_ид,
        a.вид_реал_ид,
        p.год,
        p.месяц,
        1 as порядок,
        sum(долг) сумма
    from report_dm.msr_фин_сальдо_по_дог_вид_реал a
        join период p on p.дата_с between a.акт_с and a.акт_по
        and p.договор_ид = a.договор_ид
    group by a.договор_ид,
        a.вид_реал_ид,
        p.год,
        p.месяц
),
sk as (
    select 'Конечное сальдо' as имя_стр,
        a.договор_ид,
        a.вид_реал_ид,
        p.год,
        p.месяц,
        5 as порядок,
        sum(долг) сумма
    from report_dm.msr_фин_сальдо_по_дог_вид_реал a
        join период p on p.дата_по between a.акт_с and a.акт_по
        and p.договор_ид = a.договор_ид
    group by a.договор_ид,
        a.вид_реал_ид,
        p.год,
        p.месяц
),
x as (
    select a.договор_ид,
        a.год,
        a.месяц,
        a.вид_реал_ид,
        a.вид_тов_ид,
        null as имя_стр,
        a.порядок,
        a.сумма
    from n a
    UNION ALL
    select a.договор_ид,
        a.год,
        a.месяц,
        a.вид_реал_ид,
        a.вид_тов_ид,
        null as имя_стр,
        a.порядок,
        a.сумма
    from o1 a
    UNION ALL
    select a.договор_ид,
        a.год,
        a.месяц,
        a.вид_реал_ид,
        a.вид_тов_ид,
        null as имя_стр,
        a.порядок,
        a.сумма
    from o2 a
    UNION ALL
    select a.договор_ид,
        a.год,
        a.месяц,
        a.вид_реал_ид,
        null as вид_тов_ид,
        a.имя_стр,
        a.порядок,
        a.сумма
    from o3 a
    UNION ALL
    select a.договор_ид,
        a.год,
        a.месяц,
        a.вид_реал_ид,
        null as вид_тов_ид,
        a.имя_стр,
        a.порядок,
        a.сумма
    from o4 a
    UNION ALL
    select a.договор_ид,
        a.год,
        a.месяц,
        a.вид_реал_ид,
        null as вид_тов_ид,
        a.имя_стр,
        a.порядок,
        a.сумма
    from sn a
    UNION ALL
    select a.договор_ид,
        a.год,
        a.месяц,
        a.вид_реал_ид,
        null as вид_тов_ид,
        a.имя_стр,
        a.порядок,
        a.сумма
    from sk a
),
x1 as (
    select a.*,
        coalesce(a.имя_стр, t.номер || ' ' || t.имя) строка
    from x a
        left join report_dm.dim_вид_тов t on a.вид_тов_ид = t.вид_тов_ид
)
select a.строка,
    a.договор_ид,
    a.год,
    a.месяц,
    a.вид_реал_ид,
    DENSE_RANK() over (
        order by a.порядок,
            a.строка
    ) порядок,
    a.сумма
from x1 a;
RETURN QUERY
select *
from result;
END;
$$;