interface ParamFieldProps {
  label: string;
  editor: ParamEditor;
}

class ParamField {
  label: string;
  editor: ParamEditor;
  constructor(props: ParamFieldProps) {
    this.label = props.label;
    this.editor = props.editor;
  }
}
