<template>
    <div>
        <div v-for="field in fields" :key="field.field">
            <div>{{ field.label }}</div>
            <component :is="getComponent(field.type)" v-model:value="form[field.field]" @change="updateForm" />
        </div>
    </div>
</template>

<script setup lang="ts">
//   :type="field.type === 'dateBox' ? 'date' : undefined"
//       :value-change-event="field.type === 'textBox' ? 'keyup' : undefined"
import { ref, watch } from 'vue';
import FieldDate from './reports/fields/FieldDate.vue';
import FieldText from './reports/fields/FieldText.vue';

interface Field {
    label: string;
    type: string;
    field: string;
}

const props = defineProps({
    fields: {
        type: Array as () => Field[],
        required: true
    }
});

const form = ref<any>({});

watch(form, () => {
    emit('update:form', form.value);
});

const getComponent = (type: string) => {
    switch (type) {
        case 'date':
            return FieldDate;
        case 'text':
            return FieldText;
        default:
            return null;
    }
};

const emit = defineEmits(['update:form']);

const updateForm = () => {
    emit('update:form', form.value);
};
</script>