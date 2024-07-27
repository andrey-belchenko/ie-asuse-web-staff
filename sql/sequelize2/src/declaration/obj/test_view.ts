import { View } from "../../classes/View";

export default new View({
  fileName: __filename,
  deleteStatement: `DROP VIEW IF EXISTS public.test_view CASCADE`,
});
