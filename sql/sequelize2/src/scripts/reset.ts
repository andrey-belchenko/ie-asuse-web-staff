import declaration from "../declaration/obj";
import fill_dim_data from "../declaration/obj/report_dm/functions/fill_dim_дата";
import fill_msr_фин_опл from "../declaration/obj/report_dm/functions/fill_msr_фин_опл";
import fill_msr_фин_опл_кредит from "../declaration/obj/report_dm/functions/fill_msr_фин_опл_кредит";
import fill_msr_фин_опл_погаш from "../declaration/obj/report_dm/functions/fill_msr_фин_опл_погаш";
import dim_дата from "../declaration/obj/report_dm/tables/dim_дата";
import msr_фин_опл from "../declaration/obj/report_dm/tables/msr_фин_опл";
import msr_фин_опл_кредит from "../declaration/obj/report_dm/tables/msr_фин_опл_кредит";
import msr_фин_опл_погаш from "../declaration/obj/report_dm/tables/msr_фин_опл_погаш";
import msr_фин from "../declaration/obj/report_dm/views/msr_фин";
import fill_фин_опл from "../declaration/obj/report_stg/functions/fill_фин_опл";
import фин_опл from "../declaration/obj/report_stg/tables/фин_опл";
import { resetObjects } from "../utils/management";

declaration;
const run = async () => {
  await resetObjects([
    //  фин_опл,
    //  fill_фин_опл
    // msr_фин_опл_погаш,
    // fill_msr_фин_опл_погаш
    // msr_фин_опл_кредит,
    // fill_msr_фин_опл_кредит
    msr_фин,
  ]);
  console.log("done");
};

run();
