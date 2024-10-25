<script setup>
import axios from 'axios'
import { ref, watch, defineEmits, defineProps} from 'vue'

const props = defineProps({
  clockStatus: Boolean,
});

const emit = defineEmits(['updateClockStatus']);

const toggleClockStatus = () => {
  emit('updateClockStatus', !props.clockStatus);
};
const userId = ref(4)
const startDateTime = ref('Please clock-in')
const clockIn = ref(false)


const toggleClock = async () => {
  const clockingTime = new Date(Date.now())
  const clockData = {
    status: clockIn.value,
    time: new Date().toISOString().replace(/T[\d:.]+Z$/, `T${clockingTime.toLocaleTimeString()}Z`)
  }
  try {
    const response = await axios.post(
      `http://localhost:4000/api/clocks/${userId.value}`,
      clockData,
      {
        headers: {
          'Content-Type': 'application/json'
        }
      }
    )
    console.log(`Working time created: ${JSON.stringify(response.data)}`)
    if (clockIn.value) {
      startDateTime.value = "You clocked-in at: " + clockingTime.toLocaleTimeString()
    } else {
      startDateTime.value = 'Please clock-in'
    }
    toggleClockStatus()
  } catch (error) {
    console.error('Error toggling clock:', error)
  }
}

watch(clockIn, () => {
  toggleClock()
})
</script>

<template>
  <div class="flex flex-col justify-between bg-bg-primary w-4/5 p-4 min-h-44 rounded-lg shadow-lg shrink text-center">
    <p class="text-3xl shrink">{{ startDateTime }}</p>
    <div class="shrink">
      <VaSwitch v-model="clockIn" size="large" />
    </div>
  </div>
</template>

<style scoped></style>
