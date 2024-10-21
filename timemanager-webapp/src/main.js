import './assets/main.css'
import axios from 'axios'
import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'
import router from './router'

const app = createApp(App)
app.use(createPinia())
app.use(router)

axios.defaults.baseURL = 'http://localhost:4000'
axios.defaults.withCredentials = true

axios.interceptors.request.use(config => {
    const token = localStorage.getItem('auth_token')
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`
    }
    return config
})
app.config.globalProperties.$axios = axios.create({
  baseURL: 'http://localhost:4000',
  headers: {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept',
  },
})

// Utility function to verify user permissions
const checkUserPermission = (requiredRole) => {
  const userRole = localStorage.getItem('user_role')
  return userRole === requiredRole
}

router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('auth_token')
  
  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (!token) {
      next('/login')
    } else {
      if (to.matched.some(record => record.meta.requiresAdmin)) {
        if (checkUserPermission('admin')) {
          next()
        } else {
          next('/unauthorized')
        }
      } else {
        next()
      }
    }
  } else {
    next()
  }
})
axios.interceptors.request.use(config => {
  const token = localStorage.getItem('auth_token')
  const csrfToken = localStorage.getItem('csrf_token')
  if (token) {
    config.headers['Authorization'] = `Bearer ${token}`
  }
  if (csrfToken) {
    config.headers['X-CSRF-Token'] = csrfToken
  }
  return config
})


app.mount('#app')
