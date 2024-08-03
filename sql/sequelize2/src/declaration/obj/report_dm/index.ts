import fill_msr_фин_обор from "./functions/fill_msr_фин_обор";
import fill_msr_фин_сальдо from "./functions/fill_msr_фин_сальдо_по_дог";
import report_dm from "./report_dm";
import msr_фин_обор from "./tables/msr_фин_обор";
import msr_фин_сальдо from "./tables/msr_фин_сальдо_по_дог";

export default [
  report_dm,
  msr_фин_обор,
  msr_фин_сальдо,
  fill_msr_фин_обор,
  fill_msr_фин_сальдо,
];
