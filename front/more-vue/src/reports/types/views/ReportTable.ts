import type { Column } from "devextreme/ui/data_grid";
import { ReportView, type ReportViewProps } from "../ReportView";


export interface ReportTableProps extends ReportViewProps {
  columns?: Column[];
}

export class ReportTable extends ReportView {
  columns?: Column[];
  constructor(props: ReportTableProps) {
    super(props);
    this.columns = props.columns;
  }
}
