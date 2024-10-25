<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'

const teams = ref([])
const newTeamName = ref('')
const selectedUserId = ref(null)
const selectedTeamId = ref(null)

const fetchTeams = async () => {
  const response = await axios.get('/api/teams')
  teams.value = response.data
}

const createTeam = async () => {
  await axios.post('/api/teams', { name: newTeamName.value })
  newTeamName.value = ''
  await fetchTeams()
}

const assignUserToTeam = async () => {
  if (selectedUserId.value && selectedTeamId.value) {
    await axios.post(`/api/teams/${selectedTeamId.value}/assign`, { user_id: selectedUserId.value })
    await fetchTeams()
    selectedUserId.value = null
    selectedTeamId.value = null
  }
}

onMounted(fetchTeams)
</script>

<template>
  <div class="card-container">
    <div class="card">
      <h2 class="card-title">Team Management</h2>
      <div class="form-group">
        <input v-model="newTeamName" placeholder="New team name" />
        <button @click="createTeam" class="card-button">Create Team</button>
      </div>
      <div class="form-group">
        <input v-model="selectedUserId" placeholder="User ID" />
        <input v-model="selectedTeamId" placeholder="Team ID" />
        <button @click="assignUserToTeam" class="card-button">Assign User to Team</button>
      </div>
      <ul class="team-list">
        <li v-for="team in teams" :key="team.id" class="team-item">
          {{ team.name }} (ID: {{ team.id }})
          <ul class="member-list">
            <li v-for="member in team.members" :key="member.id" class="member-item">
              {{ member.email }} (ID: {{ member.id }})
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</template>

<style scoped>
.card-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  width: 100vw;
  height: 100vh;
  background-color: #f0f2f5;
  position: fixed;
  top: 0;
  left: 0;
}

.card {
  width: 100%;
  height: 100%;
  max-width: none;
  padding: 2rem;
  background: #ffffff;
  border-radius: 0;
  box-shadow: none;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  overflow-y: auto;
}

.card-title {
  font-size: 1.5rem;
  font-weight: bold;
  text-align: center;
  margin-bottom: 1rem;
  color: #333;
}

.form-group {
  margin-bottom: 1rem;
}

.form-group input {
  width: 100%;
  padding: 0.5rem;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 1rem;
  transition: border-color 0.3s ease;
  margin-bottom: 0.5rem;
}

.form-group input:focus {
  outline: none;
  border-color: #3498db;
}

.card-button {
  background-color: #3498db;
  color: white;
  border: none;
  padding: 0.75rem;
  border-radius: 4px;
  font-size: 1rem;
  cursor: pointer;
  transition: background-color 0.3s ease;
  width: 100%;
}

.card-button:hover {
  background-color: #2980b9;
}

.team-list {
  list-style-type: none;
  padding: 0;
}

.team-item {
  margin-bottom: 1rem;
  padding: 1rem;
  background-color: #f8f9fa;
  border-radius: 4px;
}

.member-list {
  list-style-type: none;
  padding-left: 1rem;
}

.member-item {
  margin-top: 0.5rem;
}
</style>
