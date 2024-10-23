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
import TeamManager from '@/components/TeamManager/TeamManager';
import { onMounted, ref } from 'vue';

let userlist = ref()

onMounted(() => {
    TeamManager.getUsers(1).then(json => {
        userlist.value = json.data
    })
})
</script>
