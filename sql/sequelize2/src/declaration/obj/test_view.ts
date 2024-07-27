import { DdlStatement } from "../../classes/DdlStatement";
import { View } from "../../classes/View";

export default new View({
  fileName: __filename,
  deleteStatement: new DdlStatement({
    text: `DROP VIEW IF EXISTS public.test_view CASCADE`,
  }),
});
