<script setup>
import { useRouter } from 'vue-router'
import axios from 'axios'
import ButtonComponent from '../general/ButtonComponent.vue'

const router = useRouter()
const logout = () => {
  localStorage.removeItem('jwt')
  localStorage.removeItem('csrf_token')
  delete axios.defaults.headers.common['Authorization']
  delete axios.defaults.headers.common['X-CSRF-Token']
  router.push('/login')
}
</script>

<template>
  <ButtonComponent
    title = "Logout"
    path = null
    @action="logout"
  />
</template>