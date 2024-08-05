import { Table } from "../../../../classes/Table";

export default new Table({
  fileName: __filename,
  deleteStatement: /*sql*/ `DROP TABLE IF EXISTS report_dm.msr_фин_опл_кредит`,
});
