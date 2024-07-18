<template>
  <div>
    <h2 class="content-block">Tasks</h2>

    <dx-data-grid class="dx-card wide-card" :data-source="dataSourceConfig" :focused-row-index="0" :show-borders="false"
      :focused-row-enabled="true" :column-auto-width="true" :column-hiding-enabled="true">
    </dx-data-grid>
  </div>
</template>

<script>
import "devextreme/data/odata/store";
import DxDataGrid, {
  // DxColumn,
  // DxFilterRow,
  // DxLookup,
  // DxPager,
  // DxPaging
} from "devextreme-vue/data-grid";
import { createDataSource } from "../api-client/query/query.js";

const priorities = [
  { name: "High", value: 4 },
  { name: "Urgent", value: 3 },
  { name: "Normal", value: 2 },
  { name: "Low", value: 1 }
];

export default {
  setup() {
    // const dataSourceConfig = {
    //   store: {
    //     version: 2,
    //     type: "odata",
    //     key: "Task_ID",
    //     url: "https://js.devexpress.com/Demos/DevAV/odata/Tasks"
    //   },
    //   expand: "ResponsibleEmployee",
    //   select: [
    //     "Task_ID",
    //     "Task_Subject",
    //     "Task_Start_Date",
    //     "Task_Due_Date",
    //     "Task_Status",
    //     "Task_Priority",
    //     "Task_Completion",
    //     "ResponsibleEmployee/Employee_Full_Name"
    //   ]
    // };

    const dataSourceConfig = createDataSource({
      database: "bav_test_scripts",
      collectionName: "Пример сообщений от СУПА"
    })

    return {
      dataSourceConfig,
      priorities
    };
  },
  components: {
    DxDataGrid,
    // DxColumn,
    // DxFilterRow,
    // DxLookup,
    // DxPager,
    // DxPaging
  }
};
</script>
