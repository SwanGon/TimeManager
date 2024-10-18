<template>
  <div id="app">
    <nav>
      <router-link :to="'/'">
        <ButtonComponent
          title = "Timemanager"
        ></ButtonComponent>
      </router-link>
      
    </nav>
    <router-view></router-view>
  </div>
</template>

<script setup>
import ButtonComponent from './components/general/ButtonComponent.vue';

</script>
