import fill_all from "./functions/fill_all";
import fill_dim_data from "./functions/fill_dim_дата";
import fill_msr_фин_обор from "./functions/fill_msr_фин_обор";
import fill_msr_фин_сальдо from "./functions/fill_msr_фин_сальдо_по_дог";
import report_dm from "./report_dm";
import dim_дата from "./tables/dim_дата";
import msr_фин_обор from "./tables/msr_фин_обор";
import msr_фин_сальдо from "./tables/msr_фин_сальдо_по_дог";

export default [
  report_dm,
  msr_фин_обор,
  msr_фин_сальдо,
  dim_дата,
  fill_all,
  fill_msr_фин_обор,
  fill_msr_фин_сальдо,
  fill_dim_data
];
