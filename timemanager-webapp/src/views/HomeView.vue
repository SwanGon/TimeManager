<script setup>
import ClockManager from '@/components/ClockManager/ClockManager.vue';
import ButtonComponent from '@/components/general/ButtonComponent.vue'
import ProfilComponent from '@/components/general/ProfilComponent.vue'
import BarChart from '@/components/ChartManager/BarChart.vue'
import ProgressBar from '@/components/ChartManager/ProgressBar.vue'
import UserApi from '@/api/UserApi';
import { ref,onMounted } from 'vue'

const clockStatus = ref(false)
const user = ref({
  "email": '',
  "username":'',
  "team_id":'',
}
)
const teamId = localStorage.getItem("teamId")
const userId = localStorage.getItem('userId')
const updateClockStatus = (newStatus) => {
  clockStatus.value = newStatus;
};

const fetchUserProfile = async () => {
  try {
    await UserApi.getUser(localStorage.getItem('userId'))
    .then(response => {
      console.log(response.data);

      user.value = response.data
    })    
  } catch (error) {
    console.error('Error fetching user profile:', error)
  }
}

onMounted(fetchUserProfile)
</script>

<template>
  <div class="flex md:flex-row flex-col overflow-hidden">
    <div class="w-2/6 flex flex-col gap-8 justify-center items-center rounded mt-3 px-2">
      <ProfilComponent
      :username="user.username"
      :email="user.email"  />
      <ClockManager :clockStatus="clockStatus" :userId="userId" @updateClockStatus="updateClockStatus" />
      <ButtonComponent title="My Clocks" path="/" />
      <ButtonComponent title="WorkingTime" path="/workingtimes/:userid" />
    </div>
    <div class="w-4/6 flex flex-col gap-8 justify-center rounded mx-15 mt-3 px-2">
      <div class="h-1/6 flex justify-evenly items-center mt-10">
        <ProgressBar :clockStatus="clockStatus" :userId="userId"/>
      </div>
      <BarChart :userId="userId" />
      <div class="h-1/6 flex justify-around p-3 shrink">
        <ButtonComponent title="Contracts" path="/contracts" />
        <ButtonComponent title="My team" :path="`/team/${teamId}`" />
        <ButtonComponent title="Users" path="/users" />
        <ButtonComponent title="Tutorial" path="/???" />
      </div>
    </div>
  </div>
</template>
