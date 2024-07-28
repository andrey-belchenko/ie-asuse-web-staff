import { Table } from "../../../../classes/Table";

export default new Table({
  fileName: __filename,
  createStatement: /*sql*/ `CREATE SCHEMA report_dm`,
});
