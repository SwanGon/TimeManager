<script>
  import axios from 'axios'
  
  export default {
    data() {
      return {
        userId: this.$route.params.userId,
        startDateTime: null,
        clockIn: false
      }
    },
    methods: {
    refresh(data) {
      if (data && data.time) {
        this.startDateTime = data.time
        this.clockIn = data.status
      } else {
        console.error('Unexpected data structure:', data)
      }
    }
  },
  async mounted() {
    try {
      const response = await axios.get(`http://localhost:4000/api/clocks/${this.userId}`)
      this.refresh(response.data)
    } catch (error) {
      console.error('Error fetching clock data:', error)
    }
  }
}
</script>

<template>
  <div>
    <h2>Clock Manager</h2>
    <p>Start Date Time: {{ startDateTime }}</p>
    <p>Clock In: {{ clockIn }}</p>
    <button @click="clock">{{ clockIn ? 'Clock Out' : 'Clock In' }}</button>
  </div>
</template>
