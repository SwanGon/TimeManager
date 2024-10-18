<template>
    <router-view></router-view>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const userId = ref(null)

onMounted(async () => {
  try {
    const token = localStorage.getItem('auth_token')
    const response = await fetch('http://localhost:4000/api/users/me', {
      headers: {
        'Authorization': `Bearer ${token}`
      }
    })

    if (response.ok) {
      const user = await response.json()
      userId.value = user.id
    } else {
      console.error('Failed to fetch user:', response.status, response.statusText)
      router.push('/login')
    }
  } catch (error) {
    console.error('Error fetching user:', error)
    router.push('/login')
  }
})




</script>
