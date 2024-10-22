<script setup>
import ClockManager from '@/components/ClockManager/ClockManager.vue';
import ButtonComponent from '@/components/general/ButtonComponent.vue';
import { useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter()
const logout = () => {
  localStorage.removeItem('jwt')
  localStorage.removeItem('csrf_token')
  delete axios.defaults.headers.common['Authorization']
  delete axios.defaults.headers.common['X-CSRF-Token']
  router.push('/login')
}
</script>

<template>
  <div class="bg-zinc-400 flex flex-row justify-between">
    <div class="flex flex-col">
      <p class="my-8  ml-8  text-2xl font-bold">username</p>
      <button @click="logout" class="logout-button">Logout</button>

      <ClockManager/>
      <ButtonComponent
        title = "My workingtimes"
        path = "/wokringtimes/:userId"
      >
      </ButtonComponent>
    </div>
    <div class="bg-red-100">chart 1</div>
    <div class="bg-red-200">chart 2</div>
  </div>
  <div class="flex flex-row justify-between my-8 mx-8">
    <ButtonComponent
        title = "Contracts"
        path = "/contracts"
      >
    </ButtonComponent>
    <ButtonComponent
        title = "My team"
        path = "/team/id"
      >
    </ButtonComponent>
    <ButtonComponent
      title = "Tutorial"
      path = "/???"
    >
    </ButtonComponent>
    <ButtonComponent
      title = "My profile"
      path = "/users/:userId"
    >
    </ButtonComponent>
  </div>

  <!-- <nav>
    <router-link :to="'/user'">User</router-link> |
    <router-link :to="'/clock/' + userId">Clock</router-link> |
    <router-link :to="'/chart/' + userId">Charts</router-link> |
    <router-link :to="'/workingtimes/' + userId">Working Times</router-link> |
    <router-link :to="'/workingtime/' + userId">Working Time</router-link> |

  </nav> -->
  <router-view></router-view>
</template>
