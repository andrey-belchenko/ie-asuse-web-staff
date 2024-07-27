export type SqlStatementProps =
  | {
      filePath: string;
    }
  | {
      text: string;
    };

export class SqlStatement {
  text?: string;
  filePath?: string;
  constructor(props: SqlStatementProps) {
    if ("text" in props) {
      this.text = props.text;
    } else if ("filePath" in props) {
      this.filePath = props.filePath;
    }
  }
}
