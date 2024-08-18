import type { Editor } from "./Editor";

export interface FieldProps {
  label: string;
  name: string;
  editor: Editor;
}

export class Field {
  label: string;
  name: string;
  editor: Editor;
  constructor(props: FieldProps) {
    this.label = props.label;
    this.editor = props.editor;
    this.name = props.name;
  }
}
