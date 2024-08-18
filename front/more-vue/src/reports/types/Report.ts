import type { DataSource } from "./DataSource";
import type { Form } from "./Form";

export interface ReportProps {
  title: string;
  paramsForm?: Form;
  dataSource?: DataSource;
}

export class Report {
  title: string;
  paramsForm?: Form;
  dataSource?: DataSource;
  constructor(props: ReportProps) {
    this.title = props.title;
    this.paramsForm = props.paramsForm;
    this.dataSource = props.dataSource;
  }
}
