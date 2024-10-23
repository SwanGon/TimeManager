import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import ClockManager from '../components/ClockManager/ClockManager.vue'
import ChartManager from '../components/ChartManager/ChartManager.vue'
import UserManager from '@/components/UserManager/UserManager.vue'
import WorkingTimesManager from '@/components/WorkingTimesManager/WorkingTimesManager.vue'
import WorkingShiftManager from '@/components/WorkingShiftManager/WorkingShiftManager.vue'
import Contracts from '@/views/Contracts.vue'
import Contact from '@/views/Contact.vue'


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/contracts',
      name: 'contracts',
      component: Contracts
    },
    {
      path: '/contact',
      name: '/conatct',
      component: Contact
    },
    {
      path: '/workingtime/:userId',
      name: 'workingtime',
      component: WorkingShiftManager
    },
    {
      path: '/workingtimes/:userid',
      name: 'workingtimes',
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
