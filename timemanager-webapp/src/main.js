import axios from 'axios'
import './main.css'
import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'
import router from './router'
import { createVuestic } from "vuestic-ui";
import 'vuestic-ui/css'; // Default Vuestic UI styles

const app = createApp(App)
app.use(createPinia())
app.use(createVuestic());

app.use(router)

axios.defaults.withCredentials = true
axios.interceptors.request.use(config => {
  const token = localStorage.getItem('jwt')
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