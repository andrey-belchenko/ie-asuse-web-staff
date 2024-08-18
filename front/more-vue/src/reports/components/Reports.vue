<template>
    <DxSplitter id="splitter">
        <DxItem :resizable="true" :collapsible="true" size="300px" text="Left Pane">
            <ReportList @report-select="handleReportSelect" />
        </DxItem>
        <DxItem :resizable="true" :collapsible="true" size="300px" text="Left Pane">
            <div>{{ currentItem?.title }}</div>
            <ParamsForm :fields="fields" v-model:form="form" />

        </DxItem>
        <DxItem :resizable="true" :collapsible="true" text="Right Pane" min-size="70px">
            {{ JSON.stringify(form) }}
            <FieldSelect v-mode="val" />
            <!-- <FieldDate  v-model="val"/> -->
        </DxItem>
    </DxSplitter>
</template>

<script setup lang="ts">
import { DxSplitter, DxItem } from 'devextreme-vue/splitter';
import ReportList from './ReportList.vue';
import ParamsForm from './ParamsForm.vue';
import FieldSelect from './editors/FieldSelect.vue';
import FieldDate from './editors/FieldDate.vue';
import { ref } from 'vue';
import type { NavigatorItem } from '../types/Folder';
const currentItem = ref();
const val = ref<Date>();
const handleReportSelect = (item: NavigatorItem) => {
    currentItem.value = item
}

interface Field {
    label: string;
    type: string;
    field: string;
    options?: any;
}

const fields: Field[] = [
    {
        label: "Отделение",
        type: "selectDep",
        field: "dep"
    },
    {
        label: "Дата с",
        type: "date",
        field: "date1"
    },
    {
        label: "Дата по",
        type: "date",
        field: "date2"
    },
    {
        label: "Имя",
        type: "text",
        field: "name"
    }
];

const form = ref({});
</script>
