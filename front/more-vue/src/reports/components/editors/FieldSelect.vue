<template>
    <DxDropDownBox v-model:value="gridBoxValue" :defer-rendering="false" :show-clear-button="true"
        :data-source="gridDataSource" :display-expr="configuration?.displayField" :value-expr="configuration?.keyField">
        <template #content="{ data }">
            <DxDataGrid :height="345" :data-source="gridDataSource" :columns="gridColumns" :hover-state-enabled="true"
                v-model:selected-row-keys="gridBoxValue">
                <DxSelection mode="multiple" />
                <DxFilterRow :visible="true" />
                <DxScrolling mode="virtual" />
            </DxDataGrid>
        </template>
    </DxDropDownBox>
</template>
<script setup lang="ts">
import { ref, watch } from 'vue';
import DxDropDownBox from 'devextreme-vue/drop-down-box';
import {
    DxDataGrid, DxSelection, DxPaging, DxFilterRow, DxScrolling,
} from 'devextreme-vue/data-grid';
import CustomStore from 'devextreme/data/custom_store';
import type { FieldSelectOptions } from './FieldSelect';
import type { SelectEditor } from '@/reports/types/editors/system/SelectEditor';



const props = defineProps({
    modelValue: {
        type: Array,
        required: false
    },
    configuration: {
        type: Object as () => SelectEditor,
        required: false
    }
});

const gridColumns = ref(props.configuration?.columns);

const gridDataSource = makeAsyncDataSource(props.configuration?.data, props.configuration?.keyField);

const gridBoxValue = ref(props.modelValue);

const emit = defineEmits(['update:modelValue']);
watch(gridBoxValue, (newValue, oldValue) => {
    emit('update:modelValue', newValue);
});


function makeAsyncDataSource(data: any[] | undefined, idField?: string) {
    return new CustomStore({
        loadMode: 'raw',
        key: idField,
        load() {
            return data ?? [];
        },
    });
}


</script>