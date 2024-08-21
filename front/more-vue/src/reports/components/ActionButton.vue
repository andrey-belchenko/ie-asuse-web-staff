<template>

    <DxButton id="button" :width="180" :height="40" :on-click="handleClick">
        <template #content>
            <span>
                <DxLoadIndicator :visible="loadIndicatorVisible" class="button-indicator" />
                <span class="dx-button-text">{{ buttonText }}</span>
            </span>
        </template>
    </DxButton>
</template>
<script setup lang="ts">
import { ref } from 'vue';
import { DxButton } from 'devextreme-vue/button';
import { DxLoadIndicator } from 'devextreme-vue/load-indicator';

const props = defineProps({
    text: {
        type: String,
    },
    loadingText: {
        type: String,
    }
});


const loadIndicatorVisible = ref(false);
const buttonText = ref(props.text);

const emit = defineEmits<{
    (event: 'press'): void
}>()


function handleClick() {
    loadIndicatorVisible.value = true;
    buttonText.value = props.loadingText;
    emit('press');
    setTimeout(() => {
        loadIndicatorVisible.value = false;
        buttonText.value = props.text;
    }, 2000);
}
</script>
<style></style>