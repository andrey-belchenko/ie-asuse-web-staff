import declaration from "../declaration/obj";
import procedures_dm from "../declaration/obj/report_dm/procedures";
import report_stg from "../declaration/obj/report_stg";
import functions_stg from "../declaration/obj/report_stg/functions";
import procedures_stg from "../declaration/obj/report_stg/procedures";
import refresh_slice from "../declaration/obj/report_stg/tables/refresh_slice";

import { resetObjects } from "../utils/management";

declaration;
const run = async () => {
  await resetObjects([
    //  refresh_slice,
    // ...procedures_stg,
    // ...functions_stg
    ...report_stg
  ]);
  console.log("done");
};

run();
