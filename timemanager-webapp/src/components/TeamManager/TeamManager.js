import axios from 'axios'

const domain = "http://localhost:4000"
const route = "/api/teams"

const getTeams = () => {
    return axios.get(domain+route)
    .then(response => response.data)
}

const getTeam = (teamId) => {
    return axios.get(domain+route+"/"+teamId)
    .then(response => response.data)
}

const getUsers = (teamId) => {
    return axios.get(domain+route+"/"+teamId+"/users")
    .then(response => response.data)
}

const deleteTeam = (teamId) => {
    return axios.delete(domain+route+"/"+teamId)
    .then(response => response.data)
  }

export default {
    getTeams,
    getTeam,
    getUsers,
    deleteTeam
}