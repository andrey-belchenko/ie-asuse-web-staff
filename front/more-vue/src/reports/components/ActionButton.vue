<template>
    <div>
        <DxButton id="button" :width="180" :height="40" :on-click="handleClick">
            <template #content>
                <span>
                    <DxLoadIndicator :visible="loadIndicatorVisible" class="button-indicator" />
                    <span class="dx-button-text">{{ buttonText }}</span>
                </span>
            </template>
        </DxButton>
    </div>

</template>
<script setup lang="ts">
import { ref, watch } from 'vue';
import { DxButton } from 'devextreme-vue/button';
import { DxLoadIndicator } from 'devextreme-vue/load-indicator';

const props = defineProps({
    text: {
        type: String,
    },
    loadingText: {
        type: String,
    },
    loading: {
        type: Boolean
    }
});


const loadIndicatorVisible = ref(false);
const buttonText = ref(props.text);

const emit = defineEmits<{
    (event: 'click'): void
}>()

watch(() => props.loading, (newVal, oldVal) => {
    if (newVal) {
        loadIndicatorVisible.value = true;
        buttonText.value = props.loadingText;
    } else {
        loadIndicatorVisible.value = false;
        buttonText.value = props.text;
    }
});


function handleClick() {
    emit('click');
}
</script>
<style></style>