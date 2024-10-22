<template>
    <div>
        <h1>{{ message }}</h1>
        <ChildComponent />
    </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import ChildComponent from './ChildComponent.vue';

const message = ref('Hello from ParentComponent 2');
</script>