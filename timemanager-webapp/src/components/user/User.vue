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
  
  <script>
  import axios from 'axios'
  
  export default {
    data() {
      return {
        user: { username: '', email: '' }
      }
    },
    methods: {
      async createUser() {
        await axios.post('http://localhost:4000/api/users', this.user)
      },
      async updateUser() {
        await axios.put(`http://localhost:4000/api/users/${this.user.id}`, this.user)
      },
      async getUser() {
        const response = await axios.get(`http://localhost:4000/api/users/${this.user.id}`)
        this.user = response.data
      },
      async deleteUser() {
        await axios.delete(`http://localhost:4000/api/users/${this.user.id}`)
      }
    }
  }
  </script>
  