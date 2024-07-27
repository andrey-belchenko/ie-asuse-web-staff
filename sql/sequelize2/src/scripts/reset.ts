import declaration from "../declaration/obj";
import test_view from "../declaration/obj/test_view";
import { resetObjects } from "../utils/management";

declaration;
const run = async () => {
  await resetObjects([test_view]);
  console.log("done");
};

run();
