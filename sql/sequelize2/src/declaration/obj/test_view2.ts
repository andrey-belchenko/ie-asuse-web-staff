import { DdlStatement } from "../../classes/DdlStatement";
import { View } from "../../classes/View";
import test_view from "./test_view";

export default new View({
  fileName: __filename,
  dependsOn: [test_view],
  deleteStatement: new DdlStatement({
    text: `DROP VIEW IF EXISTS public.test_view2 CASCADE`,
  }),
});
