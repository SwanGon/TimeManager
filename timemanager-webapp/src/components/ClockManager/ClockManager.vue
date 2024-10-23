<script setup>
import axios from 'axios'
import { ref, onMounted, watch} from 'vue'
import ClockCard from './ClockCard.vue'

const userId = ref(1)
const startDateTime = ref('not clocked in')
const clockIn = ref(false)
const clocks = ref('')

const refresh = async () => {
  try {
    const response = await axios.get(`http://localhost:4000/api/clocks/${userId.value}`)
    clocks.value = response.data.data.slice().reverse()
    console.log(`Found clocks: ${JSON.stringify(response.data)}`)
  } catch (error) {
    console.error('Error fetching clock data:', error)
  }
}
const toggleClock = async () => {
  const clockingTime = new Date(Date.now() + 2 * 60 * 60 * 1000)
  const clockData = {
    status: clockIn.value,
    time: clockingTime.toISOString().slice(0, 19).replace('T', ' ')
  }
  try {
    const response = await axios.post(
      `http://localhost:4000/api/clocks/${userId.value}`,
      clockData,
      {
        headers: {
          'Content-Type': 'application/json'
        }
      }
    )
    refresh()
    console.log(`Working time created: ${JSON.stringify(response.data)}`)
    if (clockIn.value) {
      startDateTime.value = clockingTime.toLocaleTimeString()
    } else {
      startDateTime.value = 'not clocked in'
    }
  } catch (error) {
    console.error('Error toggling clock:', error)
  }
}

onMounted(async () => {
  refresh()
})

watch(clockIn, () => {
  toggleClock()
})
</script>

<template>
  <div class="h-4/5 flex flex-col ">
    <div class="sm:w-56 shadow-lg shrink text-center m-auto">
      <p class="text-3xl">Start Date Time: {{ startDateTime }}</p>
      <br />
      <VaSwitch v-model="clockIn" size="large" true-label="Clocked-in" false-label="Clocked-out" />
      <p class="my-4 text-2xl underline">My Clocks</p>
    </div>
    <div class="overflow-auto">
      <div v-for="(clock, index) in clocks" :key="index">
        <ClockCard :time="clock.time" :status="clock.status" />
      </div>
    </div>
  </div>
</template>

<style scoped></style>
