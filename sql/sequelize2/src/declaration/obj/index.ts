import report_dev from "./report_dev/report_dev";
import report_dm from "./report_dm";
import fill_фин_начисл from "./report_stg/functions/fill_фин_начисл";
import fill_фин_опл from "./report_stg/functions/fill_фин_опл";
import report_stg from "./report_stg/report_stg";
import фин_начисл from "./report_stg/tables/фин_начисл";
import фин_опл from "./report_stg/tables/фин_опл";

export default [
  report_stg,
  report_dev,
  фин_начисл,
  fill_фин_начисл,
  фин_опл,
  fill_фин_опл,
  ...report_dm,
];
