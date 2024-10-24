<script setup>
import { ref, reactive, onMounted } from 'vue';
import { Bar } from 'vue-chartjs';
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale,
} from 'chart.js';

// Register necessary Chart.js components for bar chart
ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale);

// Reactive reference for chart data, initially null
const chartData = ref(null);

// Chart options using reactive
const chartOptions = reactive({
  responsive: true,
  scales: {
    y: {
      min: -1,
      max: 1,
      ticks: {
        stepSize: 0.5,
      },
    },
  },
  plugins: {
    tooltip: {
      callbacks: {
        // Custom tooltip for "Didn't work" when data is 0
        label: function (tooltipItem) {
          const value = tooltipItem.raw;
          return value === 0 ? "Didn't work" : `${value} hours`;
        },
      },
    },
  },
});

// Fetch data from API
const fetchData = async () => {
  try {
    // Simulate API call (replace with your actual API endpoint)
    const apiData = await fetch("https://api.example.com/overtime-data");
    const jsonData = await apiData.json();

    // Process data and assign colors based on overtime/undertime/didn't work
    const processedData = jsonData.map((day) => {
      if (day.hours === null) return 0; // Didn't work, set to 0
      return day.hours; // Overtime/Undertime data
    });

    // Define colors for overtime, undertime, and didn't work
    const backgroundColors = jsonData.map((day) => {
      if (day.hours === null) return 'rgba(169, 169, 169, 0.6)'; // Grey for "Didn't work"
      return day.hours >= 0 ? 'rgba(75, 192, 192, 0.6)' : 'rgba(255, 99, 132, 0.6)'; // Cyan for overtime, Red for undertime
    });

    const borderColors = jsonData.map((day) => {
      if (day.hours === null) return 'rgba(169, 169, 169, 1)'; // Grey for "Didn't work"
      return day.hours >= 0 ? 'rgba(75, 192, 192, 1)' : 'rgba(255, 99, 132, 1)'; // Cyan for overtime, Red for undertime
    });

    // Update chart data
    chartData.value = {
      labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
      datasets: [
        {
          label: 'Overtime/Undertime (Hours)',
          data: processedData,
          backgroundColor: backgroundColors,
          borderColor: borderColors,
          borderWidth: 1,
        },
      ],
    };
  } catch (error) {
    console.error('Error fetching data:', error);
  }
};

// Fetch the data when the component is mounted
onMounted(() => {
  fetchData();
});
</script>
<template>
  <div class="flex gap-8 shrink mx-4 justify-center items-center">
    <div class="bg-bg-primary rounded-lg w-1/2">
      <Bar :data="chartData" :options="chartOptions" />
    </div>
  </div>
</template>
