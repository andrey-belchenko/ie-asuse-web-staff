import declaration from "../declaration/obj";
import fill_dim_data from "../declaration/obj/report_dm/functions/fill_dim_дата";
import dim_дата from "../declaration/obj/report_dm/tables/dim_дата";
import { resetObjects } from "../utils/management";


declaration;
const run = async () => {
  await resetObjects([
     dim_дата,
     fill_dim_data
  ]);
  console.log("done");
};

run();
