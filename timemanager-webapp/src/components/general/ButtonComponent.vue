<template>
    <router-link
        class="bg-red-300 hover:bg-red-400 text-gray-800 font-bold py-2 px-4 rounded inline-flex items-center"
        :to="{ path }"
        >
        <span>{{ title }}</span>
    </router-link>
</template>

<script setup>
    import { defineProps } from 'vue';

    const { title, path } = defineProps(["title", "path"])

</script>