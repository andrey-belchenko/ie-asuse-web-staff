<template>
     <ReportTable  :params="params" :report-config="reportConfig" :exec-id="execId"/>
</template>

<script setup lang="ts">
import { reactive, watchEffect } from 'vue';
import { getEditorComponent } from './ParamsForm';
import type { Form } from '../types/Form';
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

// const values = reactive<any>({});
// const emit = defineEmits(['update:values']);

// watchEffect(() => {
//     emit('update:values', values);
// });

</script>

<style scoped>

</style>