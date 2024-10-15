<template>
  <div id="app">
    <nav>
      <router-link :to="'/'">Home</router-link> |
      <router-link :to="'/user'">User</router-link> |
      <router-link :to="'/clock/' + userId">Clock</router-link> |
      <router-link :to="'/chart/' + userId">Charts</router-link> |
      <router-link :to="'/workingtimes/' + userId">Working Times</router-link> |
      <router-link :to="'/workingtime'">Working Time</router-link> |

    </nav>
    <router-view></router-view>
  </div>

</template>

<script setup>
const userId = 1
</script>
