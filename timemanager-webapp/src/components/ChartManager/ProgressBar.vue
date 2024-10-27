<script setup>
import { defineProps, ref, onMounted, watch, computed } from 'vue'
import axios from 'axios'

const workingStart = ref('')
const workingEnd = ref('')
const haveWorkingTime = ref(false)
const firstClock = ref(null)
const todaysClocks = ref(null)
const barValue = computed(() =>{
  const value = (totalMinutesWorked.value/baseWorkingTime.value)*100
  return Math.min(value, 100)
})
const barColor = ref('#4B4E6D')

const baseWorkingTime = ref(0)
const totalMinutesWorked = ref(0)
const workingMinuteLeft = computed(() => baseWorkingTime.value - totalMinutesWorked.value);

const props = defineProps({
  clockStatus: Boolean,
  userId: String
})

async function getWorkingtime() {
  try {
    const response = await axios.get(`/api/workingtimes/today/${props.userId}`, {
      params: {
        start_of_day: new Date().toISOString().replace(/T[\d:.]+Z$/, 'T00:00:00Z'),
        end_of_day: new Date().toISOString().replace(/T[\d:.]+Z$/, 'T23:59:59Z')
      },
      headers: {
        Accept: 'application/json'
      }
    })
    if (response.data.data) {
      workingStart.value = response.data.data[0].start
      workingEnd.value = response.data.data[0].end
      baseWorkingTime.value = (new Date(response.data.data[0].end) - new Date(response.data.data[0].start))
      haveWorkingTime.value = true
    }
  } catch (error) {
    console.error('Error: get working times', error)
  }
}

async function getClocks() {
  try {
    const response = await axios.get(`/api/clocks/today/${props.userId}`, {
      params: {
        start_of_day: new Date().toISOString().replace(/T[\d:.]+Z$/, 'T00:00:00Z'),
        end_of_day: new Date().toISOString().replace(/T[\d:.]+Z$/, 'T23:59:59Z')
      },
      headers: {
        Accept: 'application/json'
      }
    })
    todaysClocks.value = response.data.data
    firstClock.value = todaysClocks.value.find((item) => item.status === true).time
    totalMinutesWorked.value = calculateTotalTime(todaysClocks.value)
  } catch (error) {
    console.error('Error: get clocks ', error)
  }
}

onMounted(() => {
  getClocks()
  getWorkingtime()
})

function formatTime(dateString) {
  if (dateString == '') {
    return '00:00'
  }
  const date = new Date(dateString)
  const hours = String(date.getUTCHours()).padStart(2, '0')
  const minutes = String(date.getUTCMinutes()).padStart(2, '0')
  return `${hours}:${minutes}`
}

function calculateTotalTime(todaysClocks) {
  let totalDuration = 0

  for (let i = 0; i < todaysClocks.length; i++) {
    if (todaysClocks[i].status === true) {
      for (let j = i + 1; j < todaysClocks.length; j++) {
        if (todaysClocks[j].status === false) {
          const clockInTime = new Date(todaysClocks[i].time)
          const clockOutTime = new Date(todaysClocks[j].time)
          const duration = (clockOutTime - clockInTime)
          totalDuration += duration
          i = j
          break
        }
      }
    }
  }
  return totalDuration
}

watch(
  () => props.clockStatus,
  () => {
    getClocks()
    totalMinutesWorked.value = calculateTotalTime(todaysClocks.value)
  }
)

</script>
<template>
  <div class="bg-bg-primary text-center rounded-lg p-3 mx-8 flex justify-center">
    <div class="flex items-center">
      <h1 class="mx-2">start time: {{ formatTime(workingStart) }}</h1>
    </div>
    <VaProgressBar
      :thickness="0.2"
      :size="40"
      :model-value="barValue"
      content-inside
      :color="barColor"
    >
      <div v-if="haveWorkingTime" class="flex justify-between w-full">
        <div class="" v-if="!clockStatus">
          <div>Please Clock in</div>
        </div>
        <div v-if="clockStatus" class="shrink ml-4 flex justify-between w-full">
          <div>clocked in at: {{ formatTime(firstClock) }}</div>
          <div class=""> worked : {{ formatTime(totalMinutesWorked) }}</div>
          <div class=" mr-4">Time left today: {{ formatTime(workingMinuteLeft) }}</div>
        </div>
      </div>
      <div v-if="!haveWorkingTime" class="flex justify-between w-full">
        <div>No working time for today, contact your manager</div>
      </div>
    </VaProgressBar>
    <div class="flex items-center">
      <h1 class="mx-2">end time: {{ formatTime(workingEnd) }}</h1>
    </div>
  </div>
</template>

<style scoped></style>
