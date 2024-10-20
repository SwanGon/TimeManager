<template>
  <div class="relative">
    <VaAppBar>
      <VaButton
        icon="home"
        color="#fff"
        preset="plain"
      />
      <VaButton
        icon="info"
        color="#fff"
        preset="plain"
      />
      <VaButton
        icon="battery"
        color="#fff"
        preset="plain"
      />
      <VaSpacer />
      <VaButton
        color="#fff"
        preset="plain"
      >
        Login
      </VaButton>
      <VaButtonDropdown
        preset="plain"
        icon-color="#fff"
      >
        Content
      </VaButtonDropdown>
    </VaAppBar>
  </div>
</template>

<script setup>
// No need to declare "script" variables in this example
// as the setup script automatically handles the Composition API.
</script>

<style scoped>
/* Add custom styles here if needed */
</style>
