import { TextEditor } from "@/reports/types/editors/system/TextEditor";
import { DepSelectEditor } from "../../types/editors/custom/DepSelectEditor";
import { DateEditor } from "../../types/editors/system/DateEditor";
import { Field } from "../../types/Field";
import { Form } from "../../types/Form";
import { Report } from "../../types/Report";
import { DataSource } from "@/reports/types/DataSource";

export default new Report({
  title: "Оборотная ведомость за энергию",
  paramsForm: new Form({
    fields: [
      new Field({
        label: "Отделение",
        name: "dep",
        editor: new DepSelectEditor({}),
      }),
      new Field({
        label: "Дата с",
        name: "date1",
        editor: new DateEditor({}),
      }),
      new Field({
        label: "Дата по",
        name: "date2",
        editor: new DateEditor({}),
      }),
    ],
  }),
  dataSource: new DataSource({
    functionName: "report_util.get_оборотная_ведомость",
    paramsBinding: {
      p_дата_с: "date1",
      p_дата_по: "date2",
      p_отделение_id: "dep",
    },
  }),
});
