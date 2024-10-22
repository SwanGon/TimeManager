import axios from 'axios'

const domain = "http://localhost:4000"
const route = "/api/users"

const createUser = (user) => {
  return axios.post(domain+route, user.value)
  .then(response => response.data)
}

const updateUser = (user) => {
  return axios.put(domain+route+"/"+user.id, user.value)
  .then(response => response.data)
}

const getUsers = () => {
  return axios.get(domain+route)
    .then(response => response.data.data)
}

const getUser = (userId) => {
  return axios.get(domain+route+"/"+userId)
  .then(response => response.data.data)
}

const deleteUser = (userId) => {
  return axios.delete(domain+route+"/"+userId)
  .then(response => response.data)
}

export default {
  getUsers,
  getUser,
  deleteUser,
  updateUser,
  createUser
}
