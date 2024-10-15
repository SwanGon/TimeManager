import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import WorkingTimes from '../components/WorkingTime/WorkingTime.vue'
import WorkingTime from '../components/WorkingTime/WorkingTimes.vue'
import ClockManager from '../components/ClockManager/ClockManager.vue'
import ChartManager from '../components/ChartManager/ChartManager.vue'
import UserManager from '@/components/UserManager/UserManager.vue'


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/workingTime',
      name: 'workingTime',
      component: WorkingTime
    },
    {
      path: '/workingTime/:userId',
      name: 'workingTime',
      component: WorkingTime
    },
    {
      path: '/workingtime/:userId/:workingtimeId',
      component: WorkingTime

    },
    {
      path: '/workingtime/:userId',
      component: WorkingTime

    },
    {
      path: '/workingtimes/:userId',
      name: 'workingTimes',

      component: WorkingTimes
    },
    {
      path: '/user',
      name: 'user',
      component: UserManager
    },
    {
      path: '/clock/:userId',
      name: 'clockManager',
      component: ClockManager
    },
    {
      path: '/chart/:userId',
      name: 'chartManager',
      component: ChartManager
    }
  ]
})

export default router
