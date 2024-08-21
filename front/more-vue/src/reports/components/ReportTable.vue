<template>
    <div v-if="execId" class="rep-table">
        <DxDataGrid :data-source="dataSource" :show-borders="false" :focused-row-enabled="true"
            :default-focused-row-index="0" :column-auto-width="true" :column-hiding-enabled="false"
            :show-column-lines="true" :show-row-lines="true" :hover-state-enabled="true" :allow-column-resizing="true"
            @exporting="onExporting" column-resizing-mode="widget">
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
            <DxExport :enabled="true" :allow-export-selected-data="false" />
            <DxSelection mode="single" />
        </DxDataGrid>
    </div>

</template>

<script setup lang="ts">
import { onMounted, reactive, ref, watch, watchEffect } from 'vue';
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
import notify from 'devextreme/ui/notify';

const dataSource = ref(createDataSource({
    database: "bav_test_report",
    collectionName: "report_temp"
}));
const props = defineProps({
    params: {
        type: Object,
    },
    reportConfig: {
        type: Object as () => Report,
        required: true
    },
    execId: {
        type: String,
    }
});

const data = ref(null)
const loading = ref(false)
const error = ref(null)

const fetchData = async () => {
    if (props.execId) {
        notify("FETCH")
    }

    // loading.value = true
    // try {
    //     const response = await fetch('https://api.example.com/data')
    //     if (!response.ok) {
    //         throw new Error('Failed to fetch data')
    //     }
    //     data.value = await response.json()
    // } catch (err) {
    //     error.value = err.message
    // } finally {
    //     loading.value = false
    // }
}

onMounted(fetchData)

// watch(() => props.execId, (newVal, oldVal) => {
//     let funcPars = props.reportConfig.dataSource?.getFuncParams(props.params)
//     notify(JSON.stringify(funcPars));
// });
const onExporting = (e: DxDataGridTypes.ExportingEvent) => {
    const workbook = new Workbook();
    const worksheet = workbook.addWorksheet("Отчет");
    exportDataGrid({
        component: e.component,
        worksheet,
        autoFilterEnabled: true,
    }).then(() => {
        workbook.xlsx.writeBuffer().then((buffer: any) => {
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

}

.rep-table>.dx-widget {
    position: absolute;
    inset: 0;

}
</style>