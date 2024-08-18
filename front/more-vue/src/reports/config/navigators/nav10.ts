import { Folder } from "../../types/Folder";
import { Navigator } from "../../types/Navigator";
import { Report } from "../../types/Report";
import { repBezuchet } from "../reports";
import oborVed from "../reports/oborVed";
import rep_25316 from "../reports/rep_25316";
import rep_25316_dog from "../reports/rep_25316_dog";

export default new Navigator({
  items: [
    new Folder({
      title: "Отчеты по безучетному потреблению",
      items: [...repBezuchet],
    }),
    new Folder({
      title: "Оборотная ведомость",
      items: [
        oborVed,
        new Report({ title: "Оборотная ведомость по полученным задаткам" }),
      ],
    }),
    new Folder({
      title: "Отчеты по оплатам",
      items: [rep_25316, rep_25316_dog],
    }),
  ],
});
