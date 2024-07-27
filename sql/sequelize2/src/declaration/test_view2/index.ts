import { View } from "../../classes/View";
import test_view from "../test_view";

export default new View({
  dirname: __dirname,
  dependsOn: [test_view],
});
