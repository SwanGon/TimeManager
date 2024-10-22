<template>
    <table class="w-2/5 my-4">
        <thead class="border-black bg-gray-100 border border-collapse">
            <th class="p-3 border-r">Username</th>
            <th class="p-3">Email</th>
        </thead>
        <tbody>
            <tr :key="user.id" v-for="user in userlist"
                class="border-black bg-gray-100 border border-collapse"
            >
                <td class="p-3 text-center border-r border-black">{{ user.username }}</td>
                <td class="p-3 text-center">{{ user.email }}</td>
            </tr>
        </tbody>
    </table>
</template>

<script setup>
import { defineProps } from 'vue';
const {userlist} = defineProps([
  "userlist"
])
</script>