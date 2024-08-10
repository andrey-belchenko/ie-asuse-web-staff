import declaration from "../declaration/obj";
import fill_dim_дата from "../declaration/obj/report_dm/procedures/fill_dim_дата";

import { resetObjects } from "../utils/management";

declaration;
const run = async () => {
  await resetObjects([
     fill_dim_дата
  ]);
  console.log("done");
};

run();
