import { View } from "../../../../classes/View";

export default new View({
  fileName: __filename,
  deleteStatement: /*sql*/ `DROP VIEW IF EXISTS report_dm.dim_отделение`,
});
