
  <script>
  import { Bar, Line, Pie } from 'vue-chartjs'
  import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale, PointElement, LineElement, ArcElement } from 'chart.js'
  
  ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale, PointElement, LineElement, ArcElement)
  
  export default {
    components: { Bar, Line, Pie },
    data() {
      return {
        chartData: {
          labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
          datasets: [
            {
              label: 'Working Hours',
              backgroundColor: '#f87979',
              data: [40, 39, 10, 40, 39, 80, 40]
            }
          ]
        }
      }
    }
  }
  </script>
  <template>
    <div>
      <h2>Chart Manager</h2>
      <Bar :chart-data="chartData" />
      <Line :chart-data="chartData" />
      <Pie :chart-data="chartData" />
    </div>
  </template>