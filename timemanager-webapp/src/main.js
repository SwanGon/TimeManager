import './assets/main.css'

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

app.mount('#app')
