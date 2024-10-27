import axios from 'axios'
const route = "/api/users"

const getUsers = () => {
  return axios.get(route)
  .then(response => response.data)
}

const getUser = (userId) => {
  return axios.get(route+"/"+userId)
  .then(response => response.data)
}

export default {
  getUsers,
  getUser
}