<script setup>
import ClockManager from '@/components/ClockManager/ClockManager.vue';
import ButtonComponent from '@/components/general/ButtonComponent.vue';
import UserManager from '@/components/UserManager/UserManager';
import { onMounted, ref } from 'vue';

let currentUser = ref({
  id: null,
  username:'',
  email:'',
  team_id: null,
  role_id: null
})

onMounted(() => {
  UserManager.getUser(3)
  .then(json => {
    console.log(json);
    currentUser.value = json
  }) 
})
</script>

<template>
  <div class="bg-zinc-400 flex flex-row justify-between">
    <div class="flex flex-col">
      <p class="my-8  ml-8  text-2xl font-bold">{{ currentUser.username }}</p>
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
        path = "/teams/1"
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
  <router-view></router-view>
</template>
