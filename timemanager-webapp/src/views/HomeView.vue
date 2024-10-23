<script setup>
import ClockManager from '@/components/ClockManager/ClockManager.vue'
import ButtonComponent from '@/components/general/ButtonComponent.vue'
import ProfilComponent from '@/components/general/ProfilComponent.vue'
import ChartManager from '@/components/ChartManager/ChartManager.vue'
</script>

<template>
  <div class="flex md:flex-row flex-col gap-4 bg-bg-tertiary overflow-hidden">
    <div class="w-1/4 flex flex-col bg-bg-primary rounded mt-3 px-2 flex-1">
      <ProfilComponent />
      <ClockManager />
    </div>
    <div class="w-3/4 flex flex-col bg-bg-primary rounded mt-3 px-2 overflow-auto flex-1">
      <div class="sticky top-0 bg-bg-primary z-10 shadow-lg">
          <div class="flex justify-around p-3">
            <ButtonComponent title="Contracts" path="/contracts" />
            <ButtonComponent title="My team" path="/team/id" />
            <ButtonComponent title="Tutorial" path="/???" />
            <ButtonComponent title="WorkingTime" path="/workingtimes/:userid" />
          </div>
        </div>
      <ChartManager />
    </div>
  </div>
</template>
