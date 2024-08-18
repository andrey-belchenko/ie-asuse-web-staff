<template>
    <DxTreeView id="treeview" :items="reports" :search-enabled="true" @item-click="selectItem" />
</template>
<script setup lang="ts">
import { ref } from 'vue';
import DxTreeView from 'devextreme-vue/tree-view'
import reports from './report-list';
const currentItem = ref(reports[0]);

const emit = defineEmits(['report-select'])

function selectItem({ itemData }: { itemData: any }) {
    currentItem.value = itemData;
    emit('report-select', itemData);
}

</script>