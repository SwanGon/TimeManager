<script setup>
import { ref, onMounted, computed } from 'vue'
import { Bar } from 'vue-chartjs'
import axios from 'axios'
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

const dataDates = ref([])
const userId = 2
const requiredMinutes = 477 //in minutes

const chartData = computed(() => ({
  labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
  datasets: [
    {
      label: 'Working hours difference',
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
      position: 'top',
    },
    title: {
      display: true,
      text: 'Weekly Time Differences',
    },
  },
  scales: {
    y: {
      beginAtZero: true,
      title: {
        display: true,
        text: 'Hours Worked',
      },
      ticks: {
        callback: function(value) {
          return formatHours(value); // format the y-axis labels
        },
      },
    },
  },
};

function formatHours(hours) {
  const totalMinutes = Math.round(hours * 60);
  return `${totalMinutes} min`;
}


onMounted(async () => {
  getDates()
})

function calculateTimeWorkedForDay(entries) {
  let totalMilliseconds = 0

  for (let i = 0; i < entries.length; i += 2) {
    const startEntry = entries[i]
    const endEntry = entries[i + 1]

    if (startEntry && endEntry && startEntry.status === true && endEntry.status === false) {
      const startTime = new Date(startEntry.time)
      const endTime = new Date(endEntry.time)
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
    return (totalMinutesWorked - requiredMinutes) / 60
  })
})

async function getDates() {
  try {
    const today = new Date()
    const dayOfWeek = today.getDay()
    const daysToSubtract = dayOfWeek === 0 ? 6 : dayOfWeek - 1
    const monday = new Date(today)
    monday.setDate(today.getDate() - daysToSubtract)
    const url = `/api/clocks/today/${userId}`
    const promises = []

    for (let i = 0; i < 7; i++) {
      const currentDay = new Date(monday)
      currentDay.setDate(monday.getDate() + i)
      promises.push(
        axios.get(url, {
          params: {
            start_of_day : currentDay.toISOString().replace(/T[\d:.]+Z$/, 'T00:00:00Z'),
            end_of_day : currentDay.toISOString().replace(/T[\d:.]+Z$/, 'T23:59:59Z')
          },
          headers: {
            Accept: 'application/json'
          }
        })
      )
    }

    const responses = await Promise.all(promises)
    console.log(responses);
    dataDates.value = responses.map((response) => response.data)
  } catch (error) {
    console.error('Error:', error)
  }
}
</script>
<template>
  <div class="bg-bg-primary rounded-lg relative mx-4 h-full">
    <Bar :data="chartData" :options="chartOptions" style="width: 100%; height: 100%;" />
  </div>
</template>
