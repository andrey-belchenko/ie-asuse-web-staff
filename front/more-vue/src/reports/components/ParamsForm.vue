<template>
    <div v-if="formConfig">
        <div>{{ JSON.stringify(values) }}</div>
        <div v-for="fieldConfig in formConfig.fields" :key="fieldConfig.name">
            <div>{{ fieldConfig.label }}</div>
            <component :is="getEditorComponent(fieldConfig.editor)" :configuration="fieldConfig.editor"
                v-model="values[fieldConfig.name]" />
        </div>
    </div>
</template>

<script setup lang="ts">
import { reactive, watchEffect } from 'vue';
import { getEditorComponent } from './ParamsForm';
import type { Form } from '../types/Form';

const props = defineProps({
    formConfig: {
        type: Object as () => Form,
        required: false
    }
});

const values = reactive<any>({});
const emit = defineEmits(['update:values']);

watchEffect(() => {
    emit('update:values', values);
});

</script>