<template>
  <div class="h-screen flex flex-col size-full">
    <HeaderComponent />
    <router-view></router-view>
  </div>
</template>

<script setup>
import HeaderComponent from './components/general/HeaderComponent.vue'
import './main.css'
</script>
