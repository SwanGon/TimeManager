<script setup>
import ClockManager from '@/components/ClockManager/ClockManager.vue'
import ButtonComponent from '@/components/general/ButtonComponent.vue';
import ProfilComponent from '@/components/general/ProfilComponent.vue'
</script>

<template>
  <div class="flex md:flex-row justify-between flex-col gap-4 bg-bg-tertiary">
    <div class=" max-h-screen flex flex-col bg-bg-primary rounded mt-3 px-2">
        <ProfilComponent />
        <ClockManager />
    </div>
    <div class="bg-bg-primary rounded mt-3">
      <ButtonComponent title="Contracts" path="/contracts"> </ButtonComponent>
      <ButtonComponent title="My team" path="/team/id"> </ButtonComponent>
      <ButtonComponent title="Tutorial" path="/???"> </ButtonComponent>
      <ButtonComponent title="WorkingTime" path="/workingtimes/:userid"> </ButtonComponent>
    </div>
  </div>
</template>
