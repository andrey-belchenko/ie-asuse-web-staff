import declaration from "../declaration/obj";
import fill_msr_фин_детал from "../declaration/obj/report_dm/functions/fill_msr_фин_сальдо_по_дог";
import fill_msr_фин_обор_детал from "../declaration/obj/report_dm/functions/fill_msr_фин_обор";
import report_dm from "../declaration/obj/report_dm/report_dm";
import msr_фин_детал from "../declaration/obj/report_dm/tables/msr_фин_сальдо_по_дог";
import msr_фин_обор_детал from "../declaration/obj/report_dm/tables/msr_фин_обор";
import fill_фин_начисления from "../declaration/obj/report_stg/functions/fill_фин_начисл";
import fill_фин_опл from "../declaration/obj/report_stg/functions/fill_фин_опл";
import фин_начисления from "../declaration/obj/report_stg/tables/фин_начисл";
import фин_опл from "../declaration/obj/report_stg/tables/фин_опл";
import { resetObjects } from "../utils/management";
import fill_msr_фин_сальдо_по_дог from "../declaration/obj/report_dm/functions/fill_msr_фин_сальдо_по_дог";

declaration;
const run = async () => {
  await resetObjects([
    // фин_начисления,
    // fill_фин_начисления,
    // фин_опл,
    // fill_фин_опл,
    // report_dm,
    // msr_фин_обор_детал,
    // fill_msr_фин_обор_детал,
    // msr_фин_детал,
    fill_msr_фин_сальдо_по_дог
  ]);
  console.log("done");
};

run();
