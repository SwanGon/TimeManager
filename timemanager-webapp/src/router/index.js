import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import ClockManager from '../components/ClockManager/ClockManager.vue'
import ChartManager from '../components/ChartManager/ChartManager.vue'
import UserManager from '@/components/UserManager/UserManager.vue'
import WorkingTimeManager from '@/components/WorkingTimesManager/WorkingTimeManager.vue'
import WorkingTimesManager from '@/components/WorkingTimesManager/WorkingTimesManager.vue'


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/workingtime',
      name: 'workingtime',
      component: WorkingTimeManager
    },
    // {
    //   path: '/workingtime/:userId',
    //   name: 'workingtime',
    //   component: WorkingTimeManager
    // },
    // {
    //   path: '/workingtime/:userId/:workingtimeId',
    //   component: WorkingTimeManager

    // },
    // {
    //   path: '/workingtime/:userId',
    //   component: WorkingTimeManager

    // },
    {
      path: '/workingtimes/:userId',
      name: 'workingTimes',
      component: WorkingTimesManager
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
