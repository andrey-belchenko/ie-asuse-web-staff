<template>
    <div class="rep-table">
        <DxDataGrid :data-source="dataSource" :show-borders="false" :focused-row-enabled="true"
            :default-focused-row-index="0" :column-auto-width="true" :column-hiding-enabled="false"
            :show-column-lines="true" :show-row-lines="true" :hover-state-enabled="true" :allow-column-resizing="true"
            @exporting="onExporting"
            column-resizing-mode="widget">
            <DxRemoteOperations :filtering="true" :sorting="true" :group-paging="true" :summary="true" :grouping="true">
            </DxRemoteOperations>
            <DxPaging :enabled="false" />
            <DxFilterRow :visible="true" />
            <DxScrolling :useNative="false" mode="virtual" />
            <DxHeaderFilter :visible="true" />
            <DxFilterPanel :visible="true" />
            <DxSummary>
                <DxTotalItem column="_id" summary-type="count" />
            </DxSummary>
            <DxGroupPanel :visible="true" />
            <DxGrouping :auto-expand-all="true" />
            <DxExport :enabled="true" :allow-export-selected-data="true" />
            <DxSelection mode="multiple"/>
        </DxDataGrid>
    </div>

</template>

<script setup lang="ts">
import { reactive, ref, watchEffect } from 'vue';
import { getEditorComponent } from './ParamsForm';
import type { Form } from '../types/Form';
import {
    DxDataGrid, DxColumn, DxPaging, DxFilterRow, DxScrolling, DxHeaderFilter, DxFilterPanel, DxRemoteOperations, DxSummary, DxTotalItem,
    DxExport, DxSelection, DxGroupPanel, DxGrouping,
    type DxDataGridTypes,
} from 'devextreme-vue/data-grid';
import type { Report } from '../types/Report';
import { createDataSource } from "../../api-client/query/query.js";
import { Workbook } from 'exceljs';
import { saveAs } from 'file-saver-es';
import { exportDataGrid } from 'devextreme/excel_exporter';

const dataSource = ref(createDataSource({
    database: "bav_demo",
    collectionName: "Подстанции подг"
}));
const props = defineProps({
    params: {
        type: Object,
        required: false
    },
    reportConfig: {
        type: Object as () => Report,
        required: true
    }
});





const onExporting = (e: DxDataGridTypes.ExportingEvent) => {
  const workbook = new Workbook();
  const worksheet = workbook.addWorksheet("Отчет");
  exportDataGrid({
    component: e.component,
    worksheet,
    autoFilterEnabled: true,
  }).then(() => {
    workbook.xlsx.writeBuffer().then((buffer:any) => {
      saveAs(new Blob([buffer], { type: 'application/octet-stream' }), `${props.reportConfig.title}.xlsx`);
    });
  });
  e.cancel = true;
};

</script>

<style scoped>
.rep-table {
    position: absolute;
    inset: 0;
    /* height: 100px; */
}

.rep-table>.dx-widget {
    position: absolute;
    inset: 0;
    /* height: 100px; */
}

.form {
    margin: 5px;
}

.label {
    margin: 5px 0px 5px 0px;
}
</style>