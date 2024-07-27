drop table  if exists dm_fin;
create table dm_fin as
with a1 as (
	select customer,
		dat,
		product,
		sale,
		0 as payment
	from sale
	union all
	select customer,
		dat,
		null as product,
		0 as sale,
		payment
	from payment
)
select a1.*,
	SUM(sale - payment) OVER (
		PARTITION BY customer
		ORDER BY dat
	) as debt,
	coalesce( (LEAD(dat) OVER (
		PARTITION BY customer
		ORDER BY dat
	) - INTERVAL '1 day')::date,'9999-01-01') as debt_valid_to
from a1 order by customer,dat