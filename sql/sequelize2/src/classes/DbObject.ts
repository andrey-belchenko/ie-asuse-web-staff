import path from "path";
import { DdlStatement } from "./DdlStatement";

export type DpObjectProps = {
  fileName: string;
  createStatement?: DdlStatement | string;
  deleteStatement?: DdlStatement | string;
  dependsOn?: DbObject[];
};

export class DbObject {
  fileName: string;
  private createStatement: DdlStatement;
  private deleteStatement: DdlStatement;
  dependsOn: DbObject[];
  dependent: DbObject[] = [];
  constructor(props: DpObjectProps) {
    this.fileName = props.fileName;

    if (props.createStatement) {
      if (typeof props.createStatement === "string") {
        this.createStatement = new DdlStatement({
          text: props.createStatement,
        });
      } else {
        this.createStatement = props.createStatement;
      }
    } else {
      this.createStatement = new DdlStatement({
        filePath: this.getDefaultSqlPath(this.fileName),
      });
    }

    if (typeof props.deleteStatement === "string") {
      this.deleteStatement = new DdlStatement({
        text: props.deleteStatement,
      });
    } else {
      this.deleteStatement = props.deleteStatement!!;
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

  private getDefaultSqlPath(filePath: string) {
    let parsed = path.parse(filePath);
    let pathArray = parsed.dir.split(path.sep);
    let folderIndex = pathArray.indexOf("obj");
    if (folderIndex > -1) {
      pathArray[folderIndex] = "ddl";
    }
    let newDir = pathArray.join(path.sep);
    let newExt = ".sql";
    let newFilePath = path.format({
      root: parsed.root,
      dir: newDir,
      name: parsed.name,
      ext: newExt,
    });
    return newFilePath;
  }
}
