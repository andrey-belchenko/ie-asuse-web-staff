import { FastReportsViewer } from "@/reports/types/views/FastReportsViewer";
import { DepSelectEditor } from "../../types/editors/custom/DepSelectEditor";
import { DateEditor } from "../../types/editors/system/DateEditor";
import { Field } from "../../types/Field";
import { Form } from "../../types/Form";
import { RegularReport } from "../../types/reports/RegularReport";
import { DataSource } from "@/reports/types/DataSource";
import { ReportTable } from "@/reports/types/views/ReportTable";

export default new RegularReport({
  title: "Оборотная ведомость за энергию (FastReport)",
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
        defaultValue: () => new Date(2022, 0, 1),
      }),
      new Field({
        label: "Дата по",
        name: "date2",
        editor: new DateEditor({}),
        defaultValue: () => new Date(2022, 0, 31),
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
  view: new FastReportsViewer({templateName:"oborVed.frx"}),
});
