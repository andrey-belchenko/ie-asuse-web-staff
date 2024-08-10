import declaration from "../declaration/obj";
import procedures_dm from "../declaration/obj/report_dm/procedures";
import procedures_stg from "../declaration/obj/report_stg/procedures";

import { resetObjects } from "../utils/management";

declaration;
const run = async () => {
  await resetObjects([
     ...procedures_dm,
     ...procedures_stg
  ]);
  console.log("done");
};

run();
