import { DdlStatement } from "./DdlStatement";

export type DpObjectProps = {
  dirname: string;
  createStatement?: DdlStatement;
  deleteStatement?: DdlStatement;
};

export class DbObject {
  dirname?: string;
  private createStatement: DdlStatement;
  private deleteStatement: DdlStatement;
  constructor(props: DpObjectProps) {
    this.dirname = props.dirname;
    if (props.createStatement) {
      this.createStatement = props.createStatement;
    } else {
      this.createStatement = new DdlStatement({ filePath: "create.sql" }).init(
        this.dirname
      )!!;
    }

    if (props.deleteStatement) {
      this.deleteStatement = props.deleteStatement;
    } else {
      this.deleteStatement = new DdlStatement({ filePath: "delete.sql" }).init(
        this.dirname
      )!!;
    }
  }

  createSql(): string {
    return this.createStatement.getText();
  }

  deleteSql(): string {
    return this.deleteStatement.getText();
  }
}
