<script setup>
import axios from 'axios'
import { useRoute } from 'vue-router'
import { ref } from 'vue'

const route = useRoute()

const userId = ref(route.params.userId)
const workingTimeId = ref(route.params.workingtimeId)
const workingTime = ref({ start: '', end: '' })

async function createWorkingTime() {
  await axios.post(`http://localhost:4000/api/workingtime/${userId.value}`, workingTime)
}
async function updateWorkingTime() {
  await axios.put(`http://localhost:4000/api/workingtime/${workingTimeId.value}`, workingTime)
}
async function deleteWorkingTime() {
  await axios.delete(`http://localhost:4000/api/workingtime/${workingTimeId.value}`)
}
</script>
<template>
  <div>
    <h2>Working Time</h2>
    <input v-model="workingTime.start" type="datetime-local" />
    <input v-model="workingTime.end" type="datetime-local" />
    <button @click="createWorkingTime">Create</button>
    <button @click="updateWorkingTime">Update</button>
    <button @click="deleteWorkingTime">Delete</button>
  </div>
</template>
