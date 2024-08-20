<template>
    <DxDataGrid :data-source="dataSource" :remote-operations="true">

    </DxDataGrid>
</template>

<script setup lang="ts">
import { reactive, ref, watchEffect } from 'vue';
import { getEditorComponent } from './ParamsForm';
import type { Form } from '../types/Form';
import {
    DxDataGrid, DxColumn
} from 'devextreme-vue/data-grid';
import type { Report } from '../types/Report';
import { createDataSource } from "../../api-client/query/query.js";

const dataSource = ref(createDataSource({
    database: "bav_demo",
    collectionName: "Подстанции подг"
}));
const props = defineProps({
    params: {
        type: Object,
        required: false
    },
    reportConfig: {
        type: Object as () => Report,
        required: true
    }
});

// const values = reactive<any>({});
// const emit = defineEmits(['update:values']);

// watchEffect(() => {
//     emit('update:values', values);
// });

</script>

<style scoped>
.form {
    margin: 5px;
}

.label {
    margin: 5px 0px 5px 0px;
}
</style>