<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'

const user = ref(null)

const fetchUserProfile = async () => {
  try {
    const response = await axios.get('/api/users/profile')
    user.value = response.data
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
  <div class="card-container" v-if="user">
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
</template>

<style scoped>
.card-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  width: 100vw;
  height: 100vh;
  background-color: #f0f2f5;
  position: fixed;
  top: 0;
  left: 0;
}

.card {
  width: 100%;
  height: 100%;
  max-width: none;
  padding: 2rem;
  background: #ffffff;
  border-radius: 0;
  box-shadow: none;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.card-title {
  font-size: 1.5rem;
  font-weight: bold;
  text-align: center;
  margin-bottom: 1rem;
  color: #333;
}

.card-subtitle {
  text-align: center;
  margin-bottom: 1.5rem;
  color: #666;
}

.card-link {
  color: #3498db;
  text-decoration: none;
  font-weight: 600;
  transition: color 0.3s ease;
}

.card-link:hover {
  color: #2980b9;
}

.card-form {
  display: flex;
  flex-direction: column;
  max-width: 400px;
  margin: 0 auto;
  width: 100%;
}

.form-group {
  margin-bottom: 1rem;
}

.form-group label {
  display: block;
  margin-bottom: 0.5rem;
  color: #333;
}

.form-group input {
  width: 100%;
  padding: 0.5rem;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 1rem;
  transition: border-color 0.3s ease;
}

.form-group input:focus {
  outline: none;
  border-color: #3498db;
}

.form-options {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
}

.remember-me {
  display: flex;
  align-items: center;
  color: #666;
}

.remember-me input {
  margin-right: 0.5rem;
}

.forgot-password {
  color: #3498db;
  text-decoration: none;
  font-size: 0.9rem;
  transition: color 0.3s ease;
}

.forgot-password:hover {
  color: #2980b9;
}

.card-button {
  background-color: #3498db;
  color: white;
  border: none;
  padding: 0.75rem;
  border-radius: 4px;
  font-size: 1rem;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.card-button:hover {
  background-color: #2980b9;
}
</style>

