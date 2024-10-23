<script setup>
import { ref } from 'vue'
import { Bar, Pie } from 'vue-chartjs';
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale, ArcElement } from 'chart.js';
ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale);

ChartJS.register(
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale,
  ArcElement
)
const chartData = ref({
  labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
  datasets: [
    {
      label: 'Working Hours',
      backgroundColor: '#f87979',
      data: [40, 39, 10, 40, 39, 80, 40]
    }
  ]
})
</script>
<template>
  <div class="flex gap-8 shrink mx-4 justify-center items-center">
    <div class="bg-bg-primary rounded-lg w-1/2">
      <Bar :data="chartData"/>
    </div>
    <div class="bg-bg-primary rounded-lg w-1/2">
      <Pie :data="chartData"/>
    </div>
  </div>
</template>
