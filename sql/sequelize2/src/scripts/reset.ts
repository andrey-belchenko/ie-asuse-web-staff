import declaration from "../declaration/obj";
import example from "../declaration/obj/functions/example";
import test_view from "../declaration/obj/test_view";
import { resetObjects } from "../utils/management";

declaration;
const run = async () => {
  await resetObjects([example]);
  console.log("done");
};

run();
