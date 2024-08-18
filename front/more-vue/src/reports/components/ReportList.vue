<template>
    <DxTreeView id="treeview" :items="treeItems" :search-enabled="true" parent-id-expr="parentId" key-expr="id"
        data-structure="plain" display-expr="title" @item-click="selectItem" />
</template>
<script setup lang="ts">
import { ref } from 'vue';
import DxTreeView from 'devextreme-vue/tree-view'
import { getTreeItems, type TreeItem } from './ReportList';
import type { NavigatorItem } from '../types/Folder';

const treeItems = ref(getTreeItems());
// const currentItem = ref<NavigatorItem | undefined>(undefined);

const emit = defineEmits(['report-select'])

function selectItem({ itemData }: { itemData: TreeItem }) {
    // currentItem.value = itemData.data;
    emit('report-select', itemData.data);
}

</script>