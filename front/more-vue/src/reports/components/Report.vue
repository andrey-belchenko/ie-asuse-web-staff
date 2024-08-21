<template>
    <div class="main" v-if="reportConfig">
        <DxSplitter id="rep-splitter2">
            <DxItem :resizable="true" :collapsible="true" size="300px">

                <ParamsForm :formConfig="reportConfig?.paramsForm" v-model:values="formValues" />

                <DxToolbar class="toolbar">
                    <TbItem :options="{
                        text: 'Сформировать отчет',
                        onClick: () => {
                            execId = uuidv4();
                        },
                    }" widget="dxButton" />
                </DxToolbar>
                <DxToolbar class="toolbar">
                    <TbItem>
                        <ActionButton text="Сформировать отчет" :on-click="onSubmit" />
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
defineProps({
    reportConfig: {
        type: Object as () => Report,
        required: false
    }
});

const onSubmit = () => {
    execId.value = uuidv4();
}

const formValues = ref({});
const execId = ref<string>();

watch(formValues, (newVal, oldVal) => {
    notify(JSON.stringify(newVal));
});


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
