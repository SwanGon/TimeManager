<script setup>
</script>

<template>
  <main>
   
    <nav>
      <router-link :to="'/user'">User</router-link> |
      <router-link :to="'/clock/' + userId">Clock</router-link> |
      <router-link :to="'/chart/' + userId">Charts</router-link> |
      <router-link :to="'/workingtimes/' + userId">Working Times</router-link> |
      <router-link :to="'/workingtime/' + userId">Working Time</router-link> |

    </nav>
    <router-view></router-view>
  </main>
</template>
