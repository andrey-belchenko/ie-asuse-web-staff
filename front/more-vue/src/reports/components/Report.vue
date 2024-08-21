<template>
    <div class="main" v-if="reportConfig">
        <DxSplitter id="rep-splitter2">
            <DxItem :resizable="true" :collapsible="true" size="300px">

                <ParamsForm v-if="reportConfig?.paramsForm" :formConfig="reportConfig?.paramsForm"
                    v-model:values="formValues" />
                <DxToolbar class="toolbar">
                    <TbItem>
                        <ActionButton text="Сформировать отчет" @press="onSubmit" :loading="executing" :width="180"
                            :height="30" />
                    </TbItem>
                </DxToolbar>

            </DxItem>
            <DxItem :resizable="true" :collapsible="true" min-size="70px">
                <ReportView :params="formValues" :report-config="reportConfig" :exec-id="execId" />
            </DxItem>
        </DxSplitter>

    </div>

</template>

<script setup lang="ts">
import { DxSplitter, DxItem } from 'devextreme-vue/splitter';
import DxToolbar, { DxItem as TbItem } from 'devextreme-vue/toolbar';
import ParamsForm from './ParamsForm.vue';
import { ref, watch } from 'vue';
import { Report } from '../types/Report';
import ReportView from './ReportView.vue';
import notify from 'devextreme/ui/notify';
import { v4 as uuidv4 } from 'uuid';
import ActionButton from './ActionButton.vue';
import { runReport } from './Report';
const props = defineProps({
    reportConfig: {
        type: Object as () => Report,
        required: false
    }
});



const formValues = ref({});
const execId = ref<string>();
const executing = ref(false);

const onSubmit = () => {
    const action = async () => {
        execId.value = uuidv4();
        executing.value = true;
        await runReport(props.reportConfig!, formValues.value);
        executing.value = false;
    }
    action();
    // setTimeout(() => {

    // }, 2000);
}

// watch(formValues, (newVal, oldVal) => {
//     notify(JSON.stringify(newVal));
// });


</script>

<style scoped>
.main {
    position: absolute;
    inset: 0;
}

.toolbar {
    margin: 20px 0px;
}
</style>
