<template>
    <div>
        <p>breadcrumb TODO</p>
    </div>
    <div>
        <UserListComponent
        :userlist = userlist
        />
        <ButtonComponent
        title="Create User"
        path="/users/new"
        />
    </div>
</template>

<script setup>
import UserListComponent from '@/components/general/UserListComponent.vue';
import UserApi from '@/api/UserApi';
import { onMounted, ref } from 'vue';
import ButtonComponent from '@/components/general/ButtonComponent.vue';

let userlist = ref()

onMounted(() => {
    UserApi.getUsers().then(json => {
        console.log(json.data);
        
        userlist.value = json.data
    })
})
</script>