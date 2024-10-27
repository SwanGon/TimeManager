<template>
<div class="h-48 bg-bg-primary shadow-md w-4/5 flex rounded shrink">
  <img class=" h-full object-cover" src="../../asset/profilepic.jpg" alt="Profile Photo" />
  <div class="p-4 flex flex-col justify-center bg-bg-primary">
    <h2 class="text-xl font-semibold">{{ username }}</h2>
    <p class="mt-2">{{ email }}</p>
  </div>
</div>
</template>

<script setup>
import { defineProps } from 'vue';

const { username, email } = defineProps(['username', 'email'])

</script>

<style scoped>
</style>
