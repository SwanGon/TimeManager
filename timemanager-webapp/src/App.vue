<template>
    <div class="h-screen flex flex-col">
      <HeaderComponent/>
      <router-view/>
    </div>
</template>

<script setup>
  import HeaderComponent from './components/general/HeaderComponent.vue';
  import "./main.css"
</script>
