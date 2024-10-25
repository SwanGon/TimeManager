<script setup>
import { ref, onMounted, computed, defineProps } from 'vue'
import { Bar } from 'vue-chartjs'
import axios from 'axios'
import ButtonComponent from '@/components/general/ButtonComponent.vue'
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale
} from 'chart.js'
ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

const props = defineProps({
  userId: String
})

const dataDates = ref([])
const currentWeekIndex = ref(0)
const baseWorkingTime = ref(0)

async function getWorkingtime() {
  try {
    const response = await axios.get(`/api/workingtimes/today/${props.userId}`, {
      params: {
        start_of_day: new Date().toISOString().replace(/T[\d:.]+Z$/, 'T00:00:00Z'),
        end_of_day: new Date().toISOString().replace(/T[\d:.]+Z$/, 'T23:59:59Z')
      },
      headers: {
        Accept: 'application/json'
      }
    })
    if (response.data.data) {
      baseWorkingTime.value =
        (new Date(response.data.data[0].end) - new Date(response.data.data[0].start)) / 60000
    }
  } catch (error) {
    console.error('Error: get working times', error)
  }
}

const chartData = computed(() => ({
  labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
  datasets: [
    {
      label: '',
      data: timeDifferences.value,
      backgroundColor: (context) => {
        const value = context.dataset.data[context.dataIndex]
        return value < 0 ? '#FF4C4C' : '#4B4E6D'
      }
    }
  ]
}))

const chartOptions = {
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: {
      position: 'top'
    },
    title: {
      display: true,
      text: 'Weekly Time Differences'
    }
  },
  scales: {
    y: {
      beginAtZero: true,
      title: {
        display: true,
        text: 'Hours Worked'
      },
      ticks: {
        callback: function (value) {
          return formatHours(value)
        }
      }
    }
  }
}

function formatHours(hours) {
  const totalMinutes = Math.round(hours * 60)
  return `${totalMinutes} min`
}

onMounted(async () => {
  getDates()
  getWorkingtime()
})

function calculateTimeWorkedForDay(entries) {
  let totalMilliseconds = 0

  for (let i = 0; i < entries.length; i += 2) {
    const startEntry = entries[i]
    const endEntry = entries[i + 1]

    if (startEntry && endEntry && startEntry.status === true && endEntry.status === false) {
      const startTime = new Date(startEntry.time)
      const endTime = new Date(endEntry.time)

      console.log(startTime, endTime);

      totalMilliseconds += endTime - startTime
    }
  }

  return totalMilliseconds
}

const timeDifferences = computed(() => {
  return dataDates.value.map((dayData) => {
    if (dayData.data == 0) {
      return null
    }
    const entries = dayData.data
    const totalMilliseconds = entries.length > 0 ? calculateTimeWorkedForDay(entries) : 0
    const totalMinutesWorked = Math.floor(totalMilliseconds / 60000)
    console.log(totalMinutesWorked);
    console.log(baseWorkingTime.value + 'oui');

    return (totalMinutesWorked - baseWorkingTime.value) / 60
  })
})

async function getDates() {
  try {
    const today = new Date()
    const dayOfWeek = today.getDay()
    const daysToSubtract = dayOfWeek === 0 ? 6 : dayOfWeek - 1
    const monday = new Date(today)
    monday.setDate(today.getDate() - daysToSubtract + (currentWeekIndex.value * 7))
    console.log(monday.toISOString());

    const url = `/api/clocks/today/${props.userId}`
    const promises = []

    for (let i = 0; i < 7; i++) {
      const currentDay = new Date(monday)
      currentDay.setDate(monday.getDate() + i)
      promises.push(
        axios.get(url, {
          params: {
            start_of_day: currentDay.toISOString().replace(/T[\d:.]+Z$/, 'T00:00:00Z'),
            end_of_day: currentDay.toISOString().replace(/T[\d:.]+Z$/, 'T23:59:59Z')
          },
          headers: {
            Accept: 'application/json'
          }
        })
      )
    }
    const responses = await Promise.all(promises)
    console.log(promises);

    dataDates.value = responses.map((response) => response.data)
  } catch (error) {
    console.error('Error:', error)
  }
}

function changeWeek(step) {
  currentWeekIndex.value += step
  getDates()
}
</script>
<template>
  <div class="flex justify-between mx-4">
    <ButtonComponent title="previous week" @click="changeWeek(-1)"/>
    <ButtonComponent title="next week" @click="changeWeek(1)"/>
  </div>
  <div class="bg-bg-primary rounded-lg relative mx-4 h-full">
    <Bar :data="chartData" :options="chartOptions" style="width: 100%; height: 100%" />
  </div>
</template>
