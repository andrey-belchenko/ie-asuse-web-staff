



select год,
    месяц,
    min(дата) дата_нач,
    max(дата) дата_кон
from report_dm.dim_дата

where год=2022
GROUP BY год,
    месяц;




select * from 