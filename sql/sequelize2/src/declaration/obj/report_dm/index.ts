import fill_all from "./functions/fill_all";
import fill_dim_data from "./functions/fill_dim_дата";
import fill_msr_фин from "./functions/fill_msr_фин";
import fill_msr_фин_начисл from "./functions/fill_msr_фин_начисл";
import fill_msr_фин_обор from "./functions/fill_msr_фин_обор";
import fill_msr_фин_опл from "./functions/fill_msr_фин_опл";
import fill_msr_фин_опл_кредит from "./functions/fill_msr_фин_опл_кредит";
import fill_msr_фин_опл_погаш from "./functions/fill_msr_фин_опл_погаш";
import fill_msr_фин_сальдо from "./functions/fill_msr_фин_сальдо_по_дог";
import report_dm from "./report_dm";
import dim_дата from "./tables/dim_дата";
import msr_фин from "./tables/msr_фин";
import msr_фин_начисл from "./tables/msr_фин_начисл";
import msr_фин_обор from "./tables/msr_фин_обор";
import msr_фин_опл from "./tables/msr_фин_опл";
import msr_фин_опл_кредит from "./tables/msr_фин_опл_кредит";
import msr_фин_опл_погаш from "./tables/msr_фин_опл_погаш";
import msr_фин_сальдо from "./tables/msr_фин_сальдо_по_дог";
import msr_фин_опер from "./views/msr_фин_опер";

export default [
  report_dm,
  msr_фин_начисл,
  msr_фин_опл,
  msr_фин_обор,
  msr_фин_сальдо,
  msr_фин_опл_погаш,
  msr_фин_опл_кредит,
  msr_фин_опер,
  msr_фин,
  dim_дата,
  fill_all,
  fill_msr_фин_начисл,
  fill_msr_фин_опл,
  fill_msr_фин_обор,
  fill_msr_фин_сальдо,
  fill_dim_data,
  fill_msr_фин_опл_погаш,
  fill_msr_фин_опл_кредит,
  fill_msr_фин,
];
