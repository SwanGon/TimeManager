import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import ClockManager from '../components/ClockManager/ClockManager.vue'
import ChartManager from '../components/ChartManager/ChartManager.vue'
import UserManager from '@/components/UserManager/UserManager.vue'
import WorkingTimesManager from '@/components/WorkingTimesManager/WorkingTimesManager.vue'
import WorkingShiftManager from '@/components/WorkingShiftManager/WorkingShiftManager.vue'
import Login from '@/components/Login/Login.vue'


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView,
      meta: { requiresAuth: true }
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/workingtime/:userId',
      name: 'workingtime',
      component: WorkingShiftManager,
      meta: { requiresAuth: true }
    },
    //{
      //path: '/register',
      //name: 'register',
      //component: Registration
    //},
    //{
      //path: '/profile',
      //name: 'profile',
      //component: ProfileManagement,
      //meta: { requiresAuth: true }
    //},
    //{
      //path: '/team/create',
      //name: 'teamCreate',
      //component: TeamCreation,
      //meta: { requiresAuth: true, requiresAdmin: true }
    //},
    //{
      //path: '/team/join',
      //name: 'teamJoin',
      //component: TeamJoining,
      //meta: { requiresAuth: true }
    //},
    //{
      //path: '/team/manage',
      //name: 'teamManage',
      //component: TeamManagement,
      //meta: { requiresAuth: true, requiresAdmin: true }
    //},
    // {
    //   path: '/workingtime/',
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
