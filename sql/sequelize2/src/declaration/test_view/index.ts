import { DdlStatement } from "../../classes/DdlStatement";
import { View } from "../../classes/View";

export default new View({
  dirname: __dirname,
  createStatement: new DdlStatement({
    text: `
      CREATE OR REPLACE VIEW public.test_view
      AS select * from  public.sales s
    `,
  }),
  deleteStatement: new DdlStatement({
    text: `
      DROP VIEW IF EXISTS public.test_view CASCADE
    `,
  }),
});
// export default obj;
