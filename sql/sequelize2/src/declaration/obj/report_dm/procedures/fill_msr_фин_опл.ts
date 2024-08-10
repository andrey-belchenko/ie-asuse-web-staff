import { Procedure } from "../../../../classes/Procedure";

export default new Procedure({
  fileName: __filename,
  deleteStatement: /*sql*/ `DROP FUNCTION IF EXISTS report_dm.fill_msr_фин_опл`,
});
