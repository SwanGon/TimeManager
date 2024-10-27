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
import UserApi from '@/api/UserApi';
import { onMounted, ref } from 'vue';

let userlist = ref()

onMounted(() => {
    UserApi.getUsers().then(json => {
        console.log(json.data);
        
        userlist.value = json.data
    })
})
</script>