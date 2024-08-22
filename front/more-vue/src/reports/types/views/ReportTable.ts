import type { Column } from "devextreme/ui/data_grid";

export interface ReportTableProps {
  columns?: Column[];
}

export class ReportTable {
  columns?: Column[];
  constructor(props: ReportTableProps) {
    this.columns = props.columns;
  }
}
