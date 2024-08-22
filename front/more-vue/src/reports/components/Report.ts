import { execFunction } from "@/api-client/exec";
import type { Report } from "../types/Report";
import notify from "devextreme/ui/notify";

export interface RunReportResult {
  tempTableName: string;
}

export async function runReport(
  reportConfig: Report,
  params: any
): Promise<RunReportResult> {
  const tempTableName = "report_temp";
  const funcPars = reportConfig.dataSource!.getFuncParams(params);
  await execFunction({
    tempTableName: tempTableName,
    functionName: reportConfig.dataSource!.functionName,
    params: funcPars,
  });
  return { tempTableName: tempTableName };
}
