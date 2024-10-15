<script setup>
import axios from 'axios'
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()

const userId = ref(route.params.userId)
const startDateTime = ref(null)
const clockIn = ref(false)

function refresh(data) {
  if (data && data.time) {
    startDateTime.value = data.time
    clockIn.value = data.status
  } else {
    console.error('Unexpected data structure:', data)
  }
}
onMounted(async () => {
  try {
    const response = await axios.get(`http://localhost:4000/api/clocks/${userId.value}`)
    refresh(response.data)
  } catch (error) {
    console.error('Error fetching clock data:', error)
  }
})
</script>

<template>
  <div>
    <h2>Clock Manager</h2>
    <p>Start Date Time: {{ startDateTime }}</p>
    <p>Clock In: {{ clockIn }}</p>
    <button @click="clock">{{ clockIn ? 'Clock Out' : 'Clock In' }}</button>
  </div>
</template>
