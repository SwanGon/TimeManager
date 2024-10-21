<template>
    <table class="w-2/5 my-4">
        <thead class="border-black bg-gray-100 border border-collapse">
            <th class="p-3 border-r">Username</th>
            <th class="p-3">Email</th>
        </thead>
        <tbody>
            <tr :key="user.id" v-for="user in users"
                class="border-black bg-gray-100 border border-collapse"
            >
                <td class="p-3 text-center border-r border-black">{{ user.username }}</td>
                <td class="p-3 text-center">{{ user.email }}</td>
            </tr>
        </tbody>
    </table>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import UserManager from '../UserManager/UserManager';

let users = ref([
    {
        id: null,
        username: '',
        email: ''
    }
])

onMounted(() => {
    UserManager.getUsers().then(json => {
        users.value = json
    })
})
</script>