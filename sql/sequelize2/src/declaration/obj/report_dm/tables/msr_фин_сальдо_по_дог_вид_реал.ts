import { Table } from "../../../../classes/Table";

export default new Table({
  fileName: __filename,
  deleteStatement: /*sql*/ `DROP TABLE IF EXISTS report_dm.msr_фин_сальдо_по_дог_вид_реал`,
});
