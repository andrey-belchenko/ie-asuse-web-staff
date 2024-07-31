import report_dev from "./report_dev/report_dev";
import fill_msr_фин_обор_детал from "./report_dm/functions/fill_msr_фин_обор_детал";
import msr_фин_детал from "./report_dm/tables/msr_фин_детал";
import msr_фин_обор_детал from "./report_dm/tables/msr_фин_обор_детал";
import fill_фин_начисл from "./report_stg/functions/fill_фин_начисл";
import fill_фин_опл from "./report_stg/functions/fill_фин_опл";
import report_stg from "./report_stg/report_stg";
import report_dm from "./report_stg/report_stg";
import фин_начисл from "./report_stg/tables/фин_начисл";
import фин_опл from "./report_stg/tables/фин_опл";

export default [
  report_stg,
  report_dm,
  report_dev,
  фин_начисл,
  fill_фин_начисл,
  фин_опл,
  fill_фин_опл,
  msr_фин_обор_детал,
  fill_msr_фин_обор_детал,
  msr_фин_детал,
  fill_msr_фин_обор_детал,
];
