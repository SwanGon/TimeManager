import axios from 'axios'

const route = "/api/roles"

const getRoles = () => {
    return axios.get(route)
    .then(response => response.data.data)
}

const getRole = (roleId) => {
    return axios.get(route+"/"+roleId)
    .then(response => response.data.data)
}

export default {
    getRoles,
    getRole
}