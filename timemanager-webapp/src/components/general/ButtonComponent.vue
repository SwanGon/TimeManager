<template>
        <button type="button">{{ title }}</button>
</template>

<script setup>
    import { defineProps } from 'vue';

    const { title } = defineProps(["title"])

</script>