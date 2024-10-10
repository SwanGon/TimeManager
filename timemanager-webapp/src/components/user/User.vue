<script setup>
import axios from 'axios'
import { ref } from 'vue'

const user = ref({ username: '', email: '' })

async function createUser() {
  await axios.post('http://localhost:4000/api/users', user.value)
}

async function updateUser() {
  await axios.put(`http://localhost:4000/api/users/${user.value.id}`, user.value)
}

async function getUser() {
  const response = await axios.get(`http://localhost:4000/api/users/${user.value.id}`)
  user.value = response.data
}

async function deleteUser() {
  await axios.delete(`http://localhost:4000/api/users/${user.value.id}`)
}
</script>
<template>
  <div>
    <h2>User Management</h2>
    <input v-model="user.username" placeholder="Username">
    <input v-model="user.email" placeholder="Email">
    <button @click="createUser">Create User</button>
    <button @click="updateUser">Update User</button>
    <button @click="getUser">Get User</button>
    <button @click="deleteUser">Delete User</button>
  </div>
</template>