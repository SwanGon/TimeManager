<template>
  <div class="flex flex-col size-full ">
    <HeaderComponent />
    <router-view />
  </div>
</template>

<script setup>
import HeaderComponent from './components/general/HeaderComponent.vue'
import './main.css'
</script>
