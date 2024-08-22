import type { DataSource } from "./DataSource";
import type { Form } from "./Form";
import type { ReportView } from "./ReportView";
import { ReportTable } from "./views/ReportTable";

export interface ReportProps {
  title: string;
  paramsForm?: Form;
  dataSource?: DataSource;
  view?: ReportView;
}

export class Report {
  title: string;
  paramsForm?: Form;
  dataSource?: DataSource;
  view: ReportView;
  constructor(props: ReportProps) {
    this.title = props.title;
    this.paramsForm = props.paramsForm;
    this.dataSource = props.dataSource;
    this.view = props.view ?? new ReportTable({});
  }
}
