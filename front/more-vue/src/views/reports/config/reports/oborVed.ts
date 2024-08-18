import { Field } from "../../types/Field";
import { Form } from "../../types/Form";
import { Report } from "../../types/Report";

export default new Report({
  title: "Оборотная ведомость",
  dataSource: "report_util.get_оборотная_ведомость",
  paramsForm: new Form({
    fields: [
      new Field({
        label: "Дата с",
        name: "dat1",
      }),
    ],
  }),
});
