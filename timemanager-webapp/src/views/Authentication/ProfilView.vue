<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import UserApi from '@/api/UserApi';
import ProfilComponent from '@/components/general/ProfilComponent.vue';

const user = ref({
  "email": '',
  "username":'',
  "team_id":'',
})

const fetchUserProfile = async () => {
  try {
    await UserApi.getUser(localStorage.getItem('userId'))
    .then(response => {
      user.value = response.data
    })    
  } catch (error) {
    console.error('Error fetching user profile:', error)
  }
}

onMounted(fetchUserProfile)

const updateProfile = async () => {
  try {
    const response = await axios.put('/api/users/profile', { user: user.value })
    console.log('Profile updated successfully', response.data)
  } catch (error) {
    console.error('Error updating profile:', error)
  }
}
</script>

<template>
  <div class="flex flex-col justify-center">
    <ProfilComponent
  :username="user.username"
  :email="user.email"
  />
    <div class="card-container flex justify-center" v-if="user">
      <div class="card">
        <h2 class="card-title">User Profile</h2>
        <form @submit.prevent="updateProfile" class="card-form">
          <div class="form-group">
            <label for="email">Email</label>
            <input id="email" v-model="user.email" type="email" required />
          </div>
          <div class="form-group">
            <label for="password">Password</label>
            <input id="password" v-model="user.password" type="password" required />
          </div>
          <!-- Add more fields as needed -->
          <button type="submit" class="card-button">Update Profile</button>
        </form>
      </div>
    </div>
  </div>
</template>

<style scoped>
</style>