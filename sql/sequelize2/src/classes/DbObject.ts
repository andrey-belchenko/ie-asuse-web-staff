import { SqlStatement } from "./SqlStatement";

export type DpObjectProps = {
  //   schema?: string;
  //   name: string;
  createStatement: SqlStatement;
  deleteStatement?: SqlStatement;
};

export class DbObject {
  //   name: string;
  //   schema?: string;
  createStatement: SqlStatement;
  deleteStatement?: SqlStatement;
  constructor(props: DpObjectProps) {
    // this.name = props.name;
    // this.schema = props.schema;
    this.createStatement = props.createStatement;
    this.deleteStatement = props.deleteStatement;
  }

  createStatementText(): string {
    return this.createStatement.text!!;
  }

  deleteStatementText(): string {
    return this.deleteStatement?.text!!;
  }
}
