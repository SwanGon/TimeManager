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
    clockIn.value = data.status
    if (data.status) {
      startDateTime.value = data.time
    }
  } else {
    console.error('Unexpected data structure:', data)
  }
}
const toggleClock = async()=>{
  const currentTime = new Date().toISOString()
  try {
    const response = await axios.post(`/api/clocks/${userId.value}`, {
      status: !clockIn.value,
      time: currentTime
    })
    refresh(response.data)
    if (!clockIn.value) {
      startDateTime.value = currentTime
    }
  } catch (error) {
    console.error('Error toggling clock:', error)
  }
}
onMounted(async () => {
  try {
    const response = await axios.get(`/api/clocks/${userId.value}`)
    refresh(response.data)
  } catch (error) {
    console.error('Error fetching clock data:', error)
  }
})
</script>

<template>
  <div class="card sm:w-56 mx-8 shadow-lg">
    <h2>Clock</h2>
    <p>Start Date Time: {{ startDateTime }}</p>
    <div class="toggle-container">
      <div class="toggle-slider">
        <input type="checkbox" id="clock-toggle" v-model="clockIn" @change="toggleClock">
        <label for="clock-toggle"></label>
      </div>
      <span class="toggle-label">{{ clockIn ? 'Clocked In' : 'Clocked Out' }}</span>
    </div>
  </div>
</template>

<style scoped>
.card {
  border: 1px solid #ccc;
  border-radius: 8px;
  padding: 16px;
}

.toggle-container {
  display: flex;
  align-items: center;
}

.toggle-slider {
  display: inline-block;
  position: relative;
  width: 60px;
  height: 34px;
  margin-right: 10px;
}

.toggle-slider input {
  opacity: 0;
  width: 0;
  height: 0;
}

.toggle-slider label {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  transition: .4s;
  border-radius: 34px;
}

.toggle-slider label:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  transition: .4s;
  border-radius: 50%;
}

input:checked + label {
  background-color: #2196F3;
}

input:checked + label:before {
  transform: translateX(26px);
}

.toggle-label {
  font-size: 14px;
}
</style>