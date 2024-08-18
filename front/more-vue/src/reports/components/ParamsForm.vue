<template>
    <div>
        <div v-for="field in fields" :key="field.field">
            <div>{{ field.label }}</div>
            <component :is="getComponent(field.type)" @change="updateForm" v-model="form[field.field]" :options="field.options" />
        </div>
    </div>
</template>

<script setup lang="ts">
//   :type="field.type === 'dateBox' ? 'date' : undefined"
//       :value-change-event="field.type === 'textBox' ? 'keyup' : undefined"

// v-model:value="form[field.field]" @change="updateForm"
import { ref, watch } from 'vue';
import FieldDate from './editors/FieldDate.vue';
import FieldText from './editors/FieldText.vue';
import FieldSelect from './editors/FieldSelect.vue';
import FieldSelectDep from './editors/FieldSelectDep.vue';
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
        case 'select':
            return FieldSelect;
        case 'selectDep':
            return FieldSelectDep;
        default:
            return null;
    }
};

const emit = defineEmits(['update:form']);

const updateForm = () => {
    emit('update:form', form.value);
};
</script>