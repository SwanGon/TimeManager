<template>
  <div class="flex flex-col h-screen">
    <HeaderComponent />
    <div class="flex-1 flex overflow-hidden">
      <router-view />
    </div>
  </div>
</template>

<script setup>
import HeaderComponent from './components/general/HeaderComponent.vue'
import './main.css'
</script>
