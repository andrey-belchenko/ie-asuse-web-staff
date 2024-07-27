import { Schema } from "../../../classes/Schema";

export default new Schema({
  fileName: __filename,
  deleteStatement: `DROP SCHEMA reporting CASCADE`,
});
