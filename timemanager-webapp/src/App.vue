<template>
  <div class="h-screen flex flex-col">
    <HeaderComponent />
    <router-view />
    <DatePicker />
  </div>
</template>

<script setup>
import HeaderComponent from './components/general/HeaderComponent.vue'
import './main.css'
import DatePicker from './components/DatePicker.vue'
</script>
