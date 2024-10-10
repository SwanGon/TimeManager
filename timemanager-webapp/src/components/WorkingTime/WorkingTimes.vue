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
      if (this.userId) {
        try {
          const response = await axios.get(`http://localhost:4000/api/workingtime/${this.userId}`)
          this.workingTimes = response.data
        } catch (error) {
          console.error('Error fetching working times:', error)
        }
      }
    },
    formatDate(dateString) {
      return new Date(dateString).toLocaleString()
    }
  },
  mounted() {
    this.getWorkingTimes()
  },
  watch: {
    '$route.params.userId': function(newUserId) {
      this.userId = newUserId
      this.getWorkingTimes()
    }
  }
}
</script>
<template>
    <div>
      <h2>Working Times</h2>
      <table v-if="workingTimes.length">
        <thead>
          <tr>
            <th>Start</th>
            <th>End</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="workingTime in workingTimes" :key="workingTime.id">
            <td>{{ formatDate(workingTime.start) }}</td>
            <td>{{ formatDate(workingTime.end) }}</td>
          </tr>
        </tbody>
      </table>
      <p v-else>No working times found for this user.</p>
    </div>
  </template>
  
