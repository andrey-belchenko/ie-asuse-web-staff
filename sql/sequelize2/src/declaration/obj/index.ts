import report_dev from "./report_dev/report_dev";
import fill_фин_начисл from "./report_stg/functions/fill_фин_начисл";
import report_stg from "./report_stg/report_stg";
import report_dm from "./report_stg/report_stg";
import фин_начисл from "./report_stg/tables/фин_начисл";

export default [report_stg, report_dm, report_dev, фин_начисл, fill_фин_начисл];
