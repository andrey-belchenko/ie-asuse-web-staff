<template>
    <ReportTable :params="params" :report-config="reportConfig" />
</template>

<script setup lang="ts">
import type { RegularReport } from '../types/reports/RegularReport';
import ReportTable from './views/ReportTable.vue';
import { defineExpose } from 'vue';
import type { ReportViewComponent } from './ReportView';
import notify from 'devextreme/ui/notify';

const props = defineProps({
    params: {
        type: Object,
    },
    reportConfig: {
        type: Object as () => RegularReport,
        required: true
    },
});



const refresh = () => {
    notify("refresh")
};

defineExpose<ReportViewComponent>({
    refresh
});

</script>