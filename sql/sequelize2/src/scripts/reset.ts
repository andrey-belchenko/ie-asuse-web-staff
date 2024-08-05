import declaration from "../declaration/obj";
import fill_dim_data from "../declaration/obj/report_dm/functions/fill_dim_дата";
import fill_msr_фин_опл from "../declaration/obj/report_dm/functions/fill_msr_фин_опл";
import dim_дата from "../declaration/obj/report_dm/tables/dim_дата";
import msr_фин_опл from "../declaration/obj/report_dm/tables/msr_фин_опл";
import fill_фин_опл from "../declaration/obj/report_stg/functions/fill_фин_опл";
import фин_опл from "../declaration/obj/report_stg/tables/фин_опл";
import { resetObjects } from "../utils/management";


declaration;
const run = async () => {
  await resetObjects([
    //  фин_опл,
    //  fill_фин_опл
    msr_фин_опл,
    fill_msr_фин_опл
  ]);
  console.log("done");
};

run();
