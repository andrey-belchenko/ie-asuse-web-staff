select строка,
    год,
    месяц,
    сумма
from report_util.get_лицевая_карта(2058)
where вид_реал_ид = 2
order by год,месяц, порядок