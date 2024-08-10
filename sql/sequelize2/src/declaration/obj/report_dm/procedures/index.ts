import fill_all from "./fill_all";
import fill_dim_data from "./fill_dim_дата";
import fill_msr_фин from "./fill_msr_фин";
import fill_msr_фин_начисл from "./fill_msr_фин_начисл";
import fill_msr_фин_обор from "./fill_msr_фин_обор";
import fill_msr_фин_опл from "./fill_msr_фин_опл";
import fill_msr_фин_опл_кредит from "./fill_msr_фин_опл_кредит";
import fill_msr_фин_опл_погаш from "./fill_msr_фин_опл_погаш";
import fill_msr_фин_сальдо from "./fill_msr_фин_сальдо_по_дог";


export default [
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
