import declaration from "../declaration/obj";
import фин_начисления from "../declaration/obj/report_stg/tables/фин_начисления";
import { resetObjects } from "../utils/management";

declaration;
const run = async () => {
  await resetObjects([фин_начисления]);
  console.log("done");
};

run();
