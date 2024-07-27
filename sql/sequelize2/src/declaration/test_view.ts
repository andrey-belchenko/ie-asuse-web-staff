import { SqlStatement } from "../classes/SqlStatement";
import { View } from "../classes/View";

const obj = new View({
  createStatement: new SqlStatement({
    text: `
      CREATE OR REPLACE VIEW public.test_view
      AS select sale from  public.sales s
    `,
  }),
  deleteStatement: new SqlStatement({
    text: `
      DROP VIEW IF EXISTS public.test_view CASCADE
    `,
  }),
});
export default obj;
