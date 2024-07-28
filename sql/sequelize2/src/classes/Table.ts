import { DbObject, DpObjectProps } from "./DbObject";

export type TableProps = DpObjectProps;
export class Table extends DbObject {
  constructor(props: TableProps) {
    super(props);
  }
}
