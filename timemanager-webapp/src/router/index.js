import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import ClockManager from '../components/ClockManager/ClockManager.vue'
import ChartManager from '../components/ChartManager/ChartManager.vue'
import Register from '@/components/Login/Register.vue'
import TeamManager from'@/components/UserManager/TeamManager.vue'
import Profil from '@/components/Login/Profil.vue'
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
      component: Login,
      meta: { requiresAuth: false }
    },
    {
      path: '/register',
      name: 'Register',
      component: Register,
      meta: { requiresAuth: false }
    },
    {
      path: '/workingtime/:userId',
      name: 'workingtime',
      component: WorkingShiftManager,
      meta: { requiresAuth: true }
    },

    {
      path: '/profile',
      name: 'profile',
      component: Profil,
      meta: { requiresAuth: true }
    },
    {
      path: '/teams',
      name: 'teams',
      component: TeamManager,
      meta: { requiresAuth: true }
    },
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
    },
    {
      path: '/:pathMatch(.*)*',
      redirect: '/login'
    }
  ]
})
router.beforeEach((to, from, next) => {
  const isAuthenticated = !!localStorage.getItem('jwt')
  const userRole = localStorage.getItem('userRole')
  const publicPages = ['/login', '/register']
  const authRequired = !publicPages.includes(to.path)

  if (authRequired && !isAuthenticated) {
    next('/login')
  } else if (isAuthenticated && userRole === 'supervisor' && to.path === '/') {
    next('/teams')
  } else {
    next()
  }
})


export default router
