<!-- To use it do that you must add this to your script setup -->
<!-- import DatePicker from './components/WorkingTimesManager/WorkingTimePicker.vue' -->
<!-- then -->
<!-- <WorkingTimePicker/> -->
<template>
  <div class="working-time-creator">
    <h2>Create Working Time</h2>

    <div class="input-group">
      <label for="working-date">Working Date:</label>
      <input
        type="date"
        v-model="workingDate"
        id="working-date"
        required
      />
    </div>

    <div class="time-picker">
      <label for="start-time">Start Time:</label>
      <VaTimePicker
        v-model="startTime"
        id="start-time"
        :step="10"
        :format="timeFormat"
      />
    </div>

    <div class="time-picker">
      <label for="end-time">End Time:</label>
      <VaTimePicker
        v-model="endTime"
        id="end-time"
        :step="10"
        :format="timeFormat"
      />
    </div>

    <div class="user-id-select">
      <label for="user-id">User ID:</label>
      <select v-model="userId" id="user-id">
        <option value="" disabled>Select User ID</option>
        <option v-for="number in numberOptions" :key="number" :value="number">
          {{ number }}
        </option>
      </select>
    </div>

    <button @click="createWorkingTimes">Create Working Time</button>

    <div class="time-range" v-if="workingDate && startTime && endTime">
      <p>Selected Working Time: {{ formattedWorkingTime }}</p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';
import { VaTimePicker } from 'vuestic-ui';
import axios from 'axios';
const numberOptions = Array.from({ length: 20 }, (_, i) => i + 1);
const workingDate = ref('');
const startTime = ref(null);
const endTime = ref(null);
const timeFormat = 'HH:mm';
const userId = ref(null);

// Computed property to format the working time for display
const formattedWorkingTime = computed(() => {
  const start = startTime.value ? `${workingDate.value} ${startTime.value.toLocaleTimeString()}` : 'Not set';
  const end = endTime.value ? `${workingDate.value} ${endTime.value.toLocaleTimeString()}` : 'Not set';
  return `${start} - ${end}`;
});
// Function to create working times
const createWorkingTimes = async () => {
  if (!workingDate.value || !startTime.value || !endTime.value || !userId.value) {
    alert("Please fill in all fields and select a User ID.");
    return;
  }

  const workingTimeData = {
    user_id: userId.value, // Include the user ID
    working_start: formatDateTime(workingDate.value, startTime.value),
    working_end: formatDateTime(workingDate.value, endTime.value),
  };

  try {
    const response = await axios.post(`http://localhost:4000/api/workingtimes/${userId.value}`, workingTimeData, {
      headers: {
        'Content-Type': 'application/json',
      },
    });

    alert(`Working time created: ${JSON.stringify(response.data)}`);
  } catch (error) {
    console.error('Error creating working time:', error);
    alert('Failed to create working time. Please try again.');
  }
};

// Function to format the date and time to 'YYYY-MM-DD HH:mm:ss'
function formatDateTime(date, time) {
  const [hours, minutes] = time.toTimeString().split(':');
  return `${date} ${hours}:${minutes}:00`;
}
</script>

<style scoped>
.working-time-creator {
  max-width: 600px; /* Adjust width as needed */
  margin: 20px auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 8px;
  background-color: #f9f9f9;
}

.input-group {
  margin-bottom: 20px;
}

.time-picker {
  margin-bottom: 20px;
}

.user-selection {
  margin-bottom: 20px;
}

button {
  padding: 10px 15px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

button:hover {
  background-color: #0056b3;
}

label {
  margin-bottom: 5px;
}

.time-range {
  font-weight: bold;
  color: #333;
}
</style>
