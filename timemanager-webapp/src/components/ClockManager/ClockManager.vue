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
      async clock() {
        const response = await axios.post(`http://localhost:4000/api/clocks/${this.userId}`)
        this.refresh(response.data)
      },
      refresh(data) {
        this.startDateTime = data.time
        this.clockIn = data.status
      }
    },
    mounted() {
      this.refresh()
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