<template>
    <div>
        <DxButton id="button" :width="180" :height="40" :on-click="handleClick">
            <template #content>
                <span>
                    <DxLoadIndicator :width="25" :height="25" :visible="loading ?? false" />
                    <span class="dx-button-text">{{ loading ? loadingText : text }}</span>
                </span>
            </template>
        </DxButton>
    </div>

</template>
<script setup lang="ts">
import { DxButton } from 'devextreme-vue/button';
import { DxLoadIndicator } from 'devextreme-vue/load-indicator';

defineProps({
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

const emit = defineEmits<{
    (event: 'click'): void
}>()

function handleClick() {
    emit('click');
}
</script>
<style></style>