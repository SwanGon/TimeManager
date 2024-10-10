import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import WorkingTime from '../components/WorkingTime/WorkingTime.vue'
import WorkingTimes from '../components/WorkingTime/WorkingTimes.vue'
import User from '../components/User/User.vue'
import ClockManager from '../components/ClockManager/ClockManager.vue'
import ChartManager from '../components/ChartManager/ChartManager.vue'


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/working-time',
      name: 'working-time',
      component: WorkingTime
    },
    {
      path: '/working-times',
      name: 'working-times',
      component: WorkingTimes
    },
    {
      path: '/user',
      name: 'user',
      component: User
    },
    {
      path: '/clock-manager',
      name: 'clock-manager',
      component: ClockManager
    },
    {
      path: '/chart-manager',
      name: 'chart-manager',
      component: ChartManager
    }
  ]
})

export default router
