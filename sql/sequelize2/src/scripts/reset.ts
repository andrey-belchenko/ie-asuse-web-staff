import declaration from "../declaration/obj";
import report_dm from "../declaration/obj/report_dm";
import procedures_dm from "../declaration/obj/report_dm/procedures";
import report_stg from "../declaration/obj/report_stg";
import functions_stg from "../declaration/obj/report_stg/functions";
import procedures_stg from "../declaration/obj/report_stg/procedures";
import fill_фин_закрытие_начисл from "../declaration/obj/report_stg/procedures/fill_фин_закрытие_начисл";
import fill_фин_закрытие_кред from "../declaration/obj/report_stg/procedures/fill_фин_закрытие_кред";
import refresh_slice from "../declaration/obj/report_stg/tables/refresh_slice";
import фин_закрытие_начисл from "../declaration/obj/report_stg/tables/фин_закрытие_начисл";
import фин_закрытие_кред from "../declaration/obj/report_stg/tables/фин_закрытие_кред";

import { resetObjects } from "../utils/management";
import fill_фин_опл from "../declaration/obj/report_stg/procedures/fill_фин_опл";
import fill_фин_начисл from "../declaration/obj/report_stg/procedures/fill_фин_начисл";
import get_лицевая_карта from "../declaration/obj/report_util/лицевая_карта/get_лицевая_карта";

declaration;
const run = async () => {
  await resetObjects([
    //  refresh_slice,
    // ...procedures_stg,
    ...functions_stg,
    // ...report_stg
    // ...report_dm
    // фин_закрытие_начисл,
    // fill_фин_закрытие_начисл,
    // фин_закрытие_кред,
    // fill_фин_закрытие_кред
    // fill_фин_начисл,
    // fill_фин_опл
    get_лицевая_карта
  ]);
  console.log("done");
};

run();
