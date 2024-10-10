<template>
  <div id="app">
    <nav>
      <router-link to="/">User</router-link> |
      <router-link :to="'/workingtimes/' + userId">Working Times</router-link> |
      <router-link :to="'/clock/' + userId">Clock</router-link> |
      <router-link :to="'/chartmanager/' + userId">Charts</router-link>
    </nav>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  data() {
    return {
      userId: 1 // Replace with actual user ID
    }
  }
}
</script>
