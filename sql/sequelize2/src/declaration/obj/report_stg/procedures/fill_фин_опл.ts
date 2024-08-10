import { Procedure } from "../../../../classes/Procedure";

export default new Procedure({
  fileName: __filename,
  deleteStatement: /*sql*/ `DROP FUNCTION IF EXISTS report_stg.fill_фин_опл`,
});
