<template>
     <ReportTable  :params="params" :report-config="reportConfig" :exec-id="execId"/>
</template>

<script setup lang="ts">
import type { Report } from '../types/Report';
import ReportTable from './ReportTable.vue';

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

</script>