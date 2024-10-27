<template>
<div class="h-48 bg-bg-primary shadow-md w-4/5 flex rounded shrink">
  <img class=" h-full object-cover" src="../../asset/profilepic.jpg" alt="Profile Photo" />
  <div class="p-4 flex flex-col justify-center bg-bg-primary">
    <h2 class="text-xl font-semibold">{{ username }}</h2>
    <p class="mt-2" v-if="userMail">{{ userMail }}</p>
    <p class="mt-2" v-else>Aucun email disponible</p>
  </div>
</div>
</template>
<script setup>
import { ref, watch } from 'vue'

const username = ref(localStorage.getItem('username'))
const userMail = ref(localStorage.getItem('userMail'))

if (!username.value) {
  console.warn('Nom d\'utilisateur non trouvé dans le stockage local.')
}

watch(() => localStorage.getItem('username'), (newValue) => {
  username.value = newValue
})

watch(() => localStorage.getItem('userMail'), (newValue) => {
  userMail.value = newValue
})
</script>
<style scoped>
</style>
