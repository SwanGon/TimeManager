<template>
  <router-link
    class="bg-button hover:bg-button-hover text-button-text shrink py-2 px-4 rounded items-center"
    :to="{ path }"
  >
    <span>{{ title }}</span>
  </router-link>
</template>

<script setup>
import { defineProps } from 'vue'

const { title, path } = defineProps(['title', 'path'])
</script>
