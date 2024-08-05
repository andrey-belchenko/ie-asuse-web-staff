import { Table } from "../../../../classes/Table";
import { View } from "../../../../classes/View";

export default new View({
  fileName: __filename,
  deleteStatement: /*sql*/ `DROP VIEW IF EXISTS report_dm.msr_фин`,
});
