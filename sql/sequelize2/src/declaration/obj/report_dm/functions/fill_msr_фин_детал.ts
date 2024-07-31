import { Function } from "../../../../classes/Function";

export default new Function({
  fileName: __filename,
  deleteStatement: /*sql*/ `DROP FUNCTION IF EXISTS report_dm.fill_msr_фин_детал`,
});
