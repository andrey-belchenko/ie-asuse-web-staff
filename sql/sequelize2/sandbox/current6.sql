    select  EXTRACT(
                YEAR
                FROM дата
            )::integer год,


             EXTRACT(
                MONTH
                FROM дата
            )::integer 
            
            
             from report_dm.msr_фин_обор  where договор_ид=358 and тип_опл_ид=2

             and 

              EXTRACT(
                YEAR
                FROM дата
            )::integer = 2019
     group by

EXTRACT(
                YEAR
                FROM дата
            )::integer,

            
             EXTRACT(
                MONTH
                FROM дата
            )::integer 