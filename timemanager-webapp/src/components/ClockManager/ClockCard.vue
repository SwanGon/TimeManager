<template>
  <div class="flex justify-around text-center text-text-primary bg-bg-tertiary p-3 rounded my-3 mr-3">
    <h1 v-if="status">Clock-in</h1>
    <h1 v-if="!status">Clock-out</h1>
    <p class="">{{ formatDate(time) }}</p>
  </div>
</template>

<script setup>
import { defineProps } from 'vue'

const { time, status } = defineProps(['time', 'status'])

const formatDate = (datetimeStr) => {
  const [date, time] = datetimeStr.replace('Z', '').split('T')
  return `${time} ${date.split('-').reverse().join('/')}`
}
</script>
