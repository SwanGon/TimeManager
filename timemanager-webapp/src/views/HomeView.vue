<script setup>
import ClockManager from '@/components/ClockManager/ClockManager.vue'
import ButtonComponent from '@/components/general/ButtonComponent.vue'
import ProfilComponent from '@/components/general/ProfilComponent.vue'
import LineChart from '@/components/ChartManager/BarChart.vue'
</script>

<template>
  <div class="flex md:flex-row flex-col overflow-hidden">
    <div class="w-2/6 flex flex-col gap-8 justify-center items-center rounded mt-3 px-2">
      <ProfilComponent />
      <ClockManager />
      <ButtonComponent title="My Clocks" path="/" />
      <ButtonComponent title="WorkingTime" path="/workingtimes/:userid" />
    </div>
    <div class="w-4/6 flex flex-col gap-8 justify-center rounded mx-15 mt-3 px-2">
      <LineChart />
      <div class="flex justify-around p-3 shrink">
        <ButtonComponent title="Contracts" path="/contracts" />
        <ButtonComponent title="My team" path="/team/id" />
        <ButtonComponent title="Tutorial" path="/???" />
      </div>
    </div>
  </div>
</template>
