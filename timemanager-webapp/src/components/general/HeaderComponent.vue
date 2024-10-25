<template>
  <div
    class="flex w-full shrink p-4 bg-bg-primary justify-between align-center items-end shadow-md"
  >
    <ButtonComponent title="Timemanager" path="/"> </ButtonComponent>
    <span class="shrink font-bold text-2xl flex">
      <div>{{ formattedDate }}</div>
      <span class="mx-1">|</span>
      <div>{{ formattedTime }}</div>
    </span>
    <LogoutComponent/>
    <ButtonComponent title="profil" path="/"> </ButtonComponent>
  </div>
</template>

<script setup>
import ButtonComponent from './ButtonComponent.vue'
import LogoutComponent from '../authentication/LogoutComponent.vue'
import { ref, onMounted, onUnmounted, computed } from 'vue'

const currentTime = ref(new Date())
const updateTime = () => {
  currentTime.value = new Date()
}
onMounted(() => {
  const interval = setInterval(updateTime, 1000)
  onUnmounted(() => {
    clearInterval(interval)
  })
})
const formattedTime = computed(() => {
  return currentTime.value.toLocaleTimeString()
})

const today = ref(new Date())

const formattedDate = computed(() => {
  return today.value.toLocaleDateString('fr-FR', {
    day: 'numeric',
    month: 'numeric',
    year: 'numeric'
  })
})
</script>
