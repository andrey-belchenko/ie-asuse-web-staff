

import dim_дата from "./dim_дата";
import msr_фин from "./msr_фин";
import msr_фин_начисл from "./msr_фин_начисл";
import msr_фин_обор from "./msr_фин_обор";
import msr_фин_опл from "./msr_фин_опл";
import msr_фин_опл_кредит from "./msr_фин_опл_кредит";
import msr_фин_опл_погаш from "./msr_фин_опл_погаш";
import msr_фин_сальдо from "./msr_фин_сальдо_по_дог";

export default [
  msr_фин_начисл,
  msr_фин_опл,
  msr_фин_обор,
  msr_фин_сальдо,
  msr_фин_опл_погаш,
  msr_фин_опл_кредит,
  msr_фин,
  dim_дата,
];
