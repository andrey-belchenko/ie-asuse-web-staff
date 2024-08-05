import fill_фин_начисл from "./functions/fill_фин_начисл";
import fill_фин_опл from "./functions/fill_фин_опл";
import report_stg from "./report_stg";
import фин_начисл from "./tables/фин_начисл";
import фин_опл from "./tables/фин_опл";

export default [report_stg, фин_начисл, фин_опл, fill_фин_начисл, fill_фин_опл];
