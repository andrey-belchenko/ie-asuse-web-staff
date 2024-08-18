<template>
    <div>
        <div v-for="field in fields" :key="field.field">
            <div>{{ field.label }}</div>
            <component :is="getComponent(field.type)" @change="updateForm" v-model="values[field.field]"
                :options="field.options" />
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import { getFieldComponent } from './ParamsForm';
import type { Form } from '../types/Form';
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
    form:{
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

const emit = defineEmits(['update:values']);

const updateForm = () => {
    emit('update:values', values.value);
};
</script>