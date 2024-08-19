<template>
    <div class="main" v-if="reportConfig">
        <DxSplitter id="rep-splitter2">
            <DxItem :resizable="true" :collapsible="true" size="300px">
               
                <ParamsForm :formConfig="reportConfig?.paramsForm" v-model:values="formValues" />
                <DxToolbar class="toolbar">
                    <TbItem :options="{
                        text: 'Сформировать отчет',
                        onClick: () => {
                            // notify('Save option has been clicked!');
                        },
                    }" widget="dxButton"  />
                </DxToolbar>
            </DxItem>
            <DxItem :resizable="true" :collapsible="true" min-size="70px">
                {{ JSON.stringify(formValues) }}
            </DxItem>
        </DxSplitter>

    </div>

</template>

<script setup lang="ts">
import { DxSplitter, DxItem } from 'devextreme-vue/splitter';
import DxToolbar, { DxItem as TbItem } from 'devextreme-vue/toolbar';
import ParamsForm from './ParamsForm.vue';
import { ref } from 'vue';
import { Report } from '../types/Report';

defineProps({
    reportConfig: {
        type: Object as () => Report,
        required: false
    }
});

const formValues = ref({});
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
