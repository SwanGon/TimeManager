
  <script>
  import axios from 'axios'
  
  export default {
    data() {
      return {
        userId: this.$route.params.userId,
        workingTimes: []
      }
    },
    methods: {
      async getWorkingTimes() {
        const response = await axios.get(`http://localhost:4000/api/workingtime/${this.userId}`)
        this.workingTimes = response.data
      }
    },
    mounted() {
      this.getWorkingTimes()
    }
  }
  </script>
  <template>
    <div>
      <h2>Working Times</h2>
      <table>
        <tr v-for="workingTime in workingTimes" :key="workingTime.id">
          <td>{{ workingTime.start }}</td>
          <td>{{ workingTime.end }}</td>
        </tr>
      </table>
    </div>
  </template>
