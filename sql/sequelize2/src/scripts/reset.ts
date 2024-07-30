import declaration from "../declaration/obj";
import fill_фин_начисления from "../declaration/obj/report_stg/functions/fill_фин_начисл";
import fill_фин_опл from "../declaration/obj/report_stg/functions/fill_фин_опл";
import фин_начисления from "../declaration/obj/report_stg/tables/фин_начисл";
import фин_опл from "../declaration/obj/report_stg/tables/фин_опл";
import { resetObjects } from "../utils/management";

declaration;
const run = async () => {
  await resetObjects([
    // фин_начисления,
    // fill_фин_начисления,
    фин_опл,
    fill_фин_опл,
  ]);
  console.log("done");
};

run();
