import FieldDate from "./editors/DateEditor.vue";
import FieldText from "./editors/TextEditor.vue";
import FieldSelect from "./editors/SelectEditor.vue";
import type { Editor } from "../types/Editor";
import { DateEditor } from "../types/editors/system/DateEditor";
import { TextEditor } from "../types/editors/system/TextEditor";
import { SelectEditor } from "../types/editors/system/SelectEditor";

export const getEditorComponent = (editor: Editor) => {
  if (editor instanceof DateEditor) {
    return FieldDate;
  } else if (editor instanceof TextEditor) {
    return FieldText;
  } else if (editor instanceof SelectEditor) {
    return FieldSelect;
  } else {
    throw new Error(`Invalid editor type: ${editor}`);
  }
};
