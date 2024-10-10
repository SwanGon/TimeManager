
  <script>
  import axios from 'axios'
  
  export default {
    data() {
      return {
        userId: this.$route.params.userId,
        workingTimeId: this.$route.params.workingtimeId,
        workingTime: { start: '', end: '' }
      }
    },
    methods: {
      async createWorkingTime() {
        await axios.post(`http://localhost:4000/api/workingtime/${this.userId}`, this.workingTime)
      },
      async updateWorkingTime() {
        await axios.put(`http://localhost:4000/api/workingtime/${this.workingTimeId}`, this.workingTime)
      },
      async deleteWorkingTime() {
        await axios.delete(`http://localhost:4000/api/workingtime/${this.workingTimeId}`)
      }
    }
  }
  </script>
  <template>
    <div>
      <h2>Working Time</h2>
      <input v-model="workingTime.start" type="datetime-local">
      <input v-model="workingTime.end" type="datetime-local">
      <button @click="createWorkingTime">Create</button>
      <button @click="updateWorkingTime">Update</button>
      <button @click="deleteWorkingTime">Delete</button>
    </div>
  </template>
