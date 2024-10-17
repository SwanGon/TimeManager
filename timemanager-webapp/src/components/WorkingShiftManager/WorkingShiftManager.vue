<script setup>
import axios from 'axios'
import { useRoute } from 'vue-router'
import { ref } from 'vue'

const route = useRoute()

const userId = ref(route.params.userId)

const startTime = ref('')
const endTime = ref('')

function convertToUTC(localDateTime) {
  const date = new Date(localDateTime)
  return date.toISOString()
}

async function createWorkingShift() {
  console.log(userId.value)

  try {
    const newShift = {
      startTime: convertToUTC(startTime.value),
      endTime: convertToUTC(endTime.value)
    }
    await axios.post(`/api/workingtimes/${userId.value}`, newShift)
    console.log('Working shift created:', newShift)
  } catch (error) {
    console.error('Error creating working shift:', error)
  }
}
// async function updateWorkingTime() {
//   await axios.put(`http://localhost:4000/api/workingtimes/${workingTimeId.value}`, workingTime)
// }
// async function deleteWorkingTime() {
//   await axios.delete(`http://localhost:4000/api/workingtimes/${workingTimeId.value}`)
// }
</script>
<template>
  <div>
    <h2>Working Time</h2>
    <input v-model="startTime" type="datetime-local" />
    <input v-model="endTime" type="datetime-local" />
    <button @click="createWorkingShift()">Create</button>
    <button @click="updateWorkingTime">Update</button>
    <button @click="deleteWorkingTime">Delete</button>
  </div>
</template>
