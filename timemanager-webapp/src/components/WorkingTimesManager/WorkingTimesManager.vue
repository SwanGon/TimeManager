<script setup>
import axios from 'axios'
import { useRoute } from 'vue-router'
import { ref, onMounted, watch } from 'vue'

const route = useRoute()

const userId = ref(route.params.userId)
const workingTimes = ref([])

async function getWorkingTimes() {
  if (userId.value) {
    try {
      const response = await axios.get(`http://localhost:4000/api/workingtime/${userId.value}`)
      workingTimes.value = response.data
    } catch (error) {
      console.error('Error fetching working times:', error)
    }
  }
}

function formatDate(dateString) {
  return new Date(dateString).toLocaleString()
}

onMounted(async () => {
  getWorkingTimes()
})
watch(
  () => route.params.userId,
  (newUserId) => {
    userId.value = newUserId
    getWorkingTimes()
  }
)
</script>
<template>
  <div>
    <h2>Working Times</h2>
    <table v-if="workingTimes.length">
      <thead>
        <tr>
          <th>Start</th>
          <th>End</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="workingTime in workingTimes.value" :key="workingTime.id">
          <td>{{ formatDate(workingTime.start) }}</td>
          <td>{{ formatDate(workingTime.end) }}</td>
        </tr>
      </tbody>
    </table>
    <p v-else>No working times found for this user.</p>
  </div>
</template>
