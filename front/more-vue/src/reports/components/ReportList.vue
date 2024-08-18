<template>
    <DxTreeView id="treeview" :items="treeItems" :search-enabled="true" parent-id-expr="parentId" key-expr="id" data-structure="plain"
        display-expr="title" @item-click="selectItem" />
</template>
<script setup lang="ts">
import { ref } from 'vue';
import DxTreeView from 'devextreme-vue/tree-view'
import { getTreeItems } from './ReportList';

const treeItems = ref(getTreeItems());
const currentItem = ref(treeItems.value[0]);

const emit = defineEmits(['report-select'])

function selectItem({ itemData }: { itemData: any }) {
    currentItem.value = itemData;
    emit('report-select', itemData);
}

</script>