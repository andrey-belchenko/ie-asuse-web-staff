<template>
    <div v-if="formConfig">
        <div v-for="fieldConfig in formConfig.fields" :key="fieldConfig.name">
            <div>{{ fieldConfig.label }}</div>
            <component :is="getEditorComponent(fieldConfig.editor)" @change="updateForm"
                v-model="values[fieldConfig.name]" />
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import { getFieldComponent, getEditorComponent } from './ParamsForm';
import type { Form } from '../types/Form';
import type { Editor } from '../types/Editor';
interface Field {
    label: string;
    type: string;
    field: string;
    options?: any;
}

const props = defineProps({
    fields: {
        type: Array as () => Field[],
        required: true
    },
    formConfig: {
        type: Object as () => Form,
        required: false
    }
});

const values = ref<any>({});

watch(values, () => {
    emit('update:values', values.value);
});

const getComponent = (type: string) => {
    return getFieldComponent(type)
};

const getFieldEditorComponent = (editorConfig: Editor) => {
    return getEditorComponent(editorConfig)
};


const emit = defineEmits(['update:values']);

const updateForm = () => {
    emit('update:values', values.value);
};
</script>