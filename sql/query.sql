with a1 as (
select 
	m.name as period,
	a.customer,
	case when a.dat between m.begin_date and m.end_date then a.sale end as sales,
	case when a.dat between m.begin_date and m.end_date then a.payment end as payments,
	case when m.begin_date between a.dat and a.debt_valid_to then debt end as beg_debt,
	case when m.end_date between a.dat and a.debt_valid_to then debt end as end_debt
from 
dm_fin a
cross join months m
)

select period,customer, sum(beg_debt) beg_debt , sum (sales) sales , sum(payments) payments, sum(end_debt) end_debt from a1
group by period,customer
order by customer,period




