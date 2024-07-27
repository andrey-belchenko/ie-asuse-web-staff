import { Function } from "../../../classes/Function";

export default new Function({
  fileName: __filename,
  deleteStatement: `DROP FUNCTION IF EXISTS reporting.example CASCADE`,
});
