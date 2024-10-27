<template>
    <div>
        <p>breadcrumb TODO</p>
    </div>
    <div>
        <UserListComponent
        :userlist = userlist
        />
    </div>
</template>

<script setup>
import UserListComponent from '@/components/general/UserListComponent.vue';
import TeamManager from '@/components/UserManager/TeamManager';
import { onMounted, ref } from 'vue';

let userlist = ref()

onMounted(() => {
    TeamManager.getUsersByTeam(localStorage.getItem("teamId")).then(json => {
        userlist.value = json.data
    })
})
</script>