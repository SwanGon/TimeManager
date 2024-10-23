<template>
  <router-link
    class="bg-button hover:bg-button-hover text-button-text text-center shrink py-2 px-4 rounded items-center w-56 text-2xl underline"
    :to="{ path }"
  >
    <span>{{ title }}</span>
  </router-link>
</template>

<script setup>
import { defineProps } from 'vue'

const { title, path } = defineProps(['title', 'path'])
</script>
