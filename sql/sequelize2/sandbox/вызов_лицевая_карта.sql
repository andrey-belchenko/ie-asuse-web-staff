select строка,
    год,
    месяц,
    max(порядок) порядок,
    sum(сумма) сумма
from report_util.get_лицевая_карта(
    ARRAY [2058]
    --ARRAY [358]
    )
where вид_реал_id in ( 0)
group by строка,
    год,
    месяц
order by год,
    месяц,
    порядок