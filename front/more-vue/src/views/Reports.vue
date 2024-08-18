<template>
    <DxSplitter id="splitter">
        <DxItem :resizable="true" :collapsible="true" size="300px" text="Left Pane">
            <ReportList @report-select="handleReportSelect" />
        </DxItem>
        <DxItem :resizable="true" :collapsible="true" size="300px" text="Left Pane">
            <div>{{ currentItem?.text }}</div>
        </DxItem>
        <DxItem :resizable="true" :collapsible="true" text="Right Pane" min-size="70px" />
    </DxSplitter>
</template>

<script setup lang="ts">
import { DxSplitter, DxItem } from 'devextreme-vue/splitter';
import ReportList from './ReportList.vue';
import { ref } from 'vue';
const currentItem = ref();

const handleReportSelect = (itemData: any) => {
    currentItem.value = itemData
}
</script>