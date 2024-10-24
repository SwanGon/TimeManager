<template>
  <div class="bg-bg-primary text-center rounded-lg p-3 mx-8 flex justify-center">
    <div class="flex items-center">
      <h1 class="mx-2">start time: {{ workingStart }}</h1>
    </div>
    <VaProgressBar :thickness="0.2" :size="40" :model-value="value" content-inside color="#4B4E6D">
      <div v-if="haveWorkingTime" class="flex justify-between w-full">
        <div class="shrink ml-4">clocked in at: {{ formatTime(firstClock) }}</div>
        <div class="shrink">2</div>
        <div class="shrink mr-4">estimated clock-out</div>
      </div>
      <div v-if="!haveWorkingTime" class="flex justify-between w-full">
        <div>No working time for today, contact your manager</div>
      </div>
    </VaProgressBar>
    <div class="flex items-center">
      <h1 class="mx-2">end time: {{ workingEnd }}</h1>
    </div>
  </div>
</template>

<script setup>
import axios from 'axios'

import { ref, onMounted } from 'vue'

async function getWorkingtime() {
  try {
    const response = await axios.get(`/api/workingtimes/today/${userId}`, {
      params: {
        start_of_day : new Date().toISOString().replace(/T[\d:.]+Z$/, 'T00:00:00Z'),
        end_of_day : new Date().toISOString().replace(/T[\d:.]+Z$/, 'T23:59:59Z')
      },
      headers: {
        Accept: 'application/json'
      }
    })
    if (response.data.data) {
      workingStart.value = formatTime(response.data.data[0].start)
      workingEnd.value = formatTime(response.data.data[0].end)
      haveWorkingTime.value = true
    }

  } catch (error) {
    console.error('Error: get working times', error)
  }
}

async function getClocks() {
  try {
    const response = await axios.get(`/api/clocks/today/${userId}`, {
      params: {
        start_of_day : new Date().toISOString().replace(/T[\d:.]+Z$/, 'T00:00:00Z'),
        end_of_day : new Date().toISOString().replace(/T[\d:.]+Z$/, 'T23:59:59Z')
      },
      headers: {
        Accept: 'application/json'
      }
    })
    todaysClocks.value = response.data.data
    firstClock.value = todaysClocks.value.find(item => item.status === true).time
  } catch (error) {
    console.error('Error: get clocks ', error)
  }
}

onMounted(() => {
  getClocks()
  getWorkingtime()
})

function formatTime(dateString) {
  const date = new Date(dateString)
  const hours = String(date.getUTCHours()).padStart(2, '0')
  const minutes = String(date.getUTCMinutes()).padStart(2, '0')
  return `${hours}:${minutes}`
}

const workingStart = ref('00:00')
const workingEnd = ref('23:59')
const haveWorkingTime = ref(false)
const firstClock = ref(null)
const todaysClocks = ref(null)
const userId = 1
const value = ref(30)
</script>

<style scoped></style>
