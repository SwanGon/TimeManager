import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'

import { createVuestic } from "vuestic-ui";
import 'vuestic-ui/css'; // Default Vuestic UI styles
import 'material-design-icons-iconfont/dist/material-design-icons.min.css'; // Material Design Icons

const app = createApp(App)

app.use(createPinia())
app.use(createVuestic());

app.use(router)

app.mount('#app')
