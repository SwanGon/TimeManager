<template>
  <div id="app">
    <nav>
      <routerLink to="/">Home</routerLink> |
      <routerLink to="/user">User</routerLink> |
      <router-link :to="'/clock/' + userId">Clock</router-link> |
      <router-link :to="'/chartManager/' + userId">Charts</router-link> |
      <router-link :to="'/workingTimes/' + userId">Working Times</router-link> |
      <routerLink to="/workingTime">Working Times</routerLink> |
        
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
