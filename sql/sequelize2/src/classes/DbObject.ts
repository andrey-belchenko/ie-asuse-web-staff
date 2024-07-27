import { DdlStatement } from "./DdlStatement";

export type DpObjectProps = {
  dirname: string;
  createStatement?: DdlStatement;
  deleteStatement?: DdlStatement;
  dependsOn?: DbObject[];
};

export class DbObject {
  dirname: string;
  private createStatement: DdlStatement;
  private deleteStatement: DdlStatement;
  dependsOn: DbObject[];
  dependent: DbObject[] = [];
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

    this.dependsOn = props.dependsOn || [];
    for (let parent of this.dependsOn) {
      parent.dependent.push(this);
    }
  }

  createSql(): string {
    return this.createStatement.getText();
  }

  deleteSql(): string {
    return this.deleteStatement.getText();
  }
}
