<template>
  <router-link
    class="bg-button hover:bg-button-hover text-button-text text-center shrink py-2 px-4 rounded items-center w-56 text-2xl underline"
    :to="{ path }"
    @click="$emit('action')"
  >  
    <span>{{ title }}</span>
  </router-link>
</template>

<script setup>
import { defineProps, defineEmits } from 'vue'

const { title, path } = defineProps(['title', 'path'])
defineEmits('action')
</script>