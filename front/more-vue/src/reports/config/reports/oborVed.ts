import { DepSelectEditor } from "../../types/editors/custom/DepSelectEditor";
import { DateEditor } from "../../types/editors/system/DateEditor";
import { Field } from "../../types/Field";
import { Form } from "../../types/Form";
import { Report } from "../../types/Report";

export default new Report({
  title: "Оборотная ведомость за энергию",
  dataSource: "report_util.get_оборотная_ведомость",
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
});
