<template>
  <div id="app">
    <nav>
      <router-link :to="'/'">Home</router-link> | <router-link :to="'/user'">User</router-link> |
      <router-link :to="'/clock/' + userId">Clock</router-link> |
      <router-link :to="'/chart/' + userId">Charts</router-link> |
      <router-link :to="'/workingtimes/' + userId">Working Times</router-link> |
      <router-link :to="'/workingtime/' + userId">Working Time</router-link> |
    </nav>
    <router-view></router-view>
  </div>
  <VaProgressCircle v-model="value" :color="progressColor" />
  <VaButton color="info" gradient class="mr-6 mb-2" @click="valueplus"> +10 </VaButton>
  <VaButton color="danger" gradient class="mr-6 mb-2" @click="valueless"> -10</VaButton>
  <span>{{ value }}</span>
  <div class="row">
    <div class="flex flex-col md6 lg4 h-48">
      <VaInfiniteScroll :load="appendRecordsAsync">
        <div v-for="(record, index) in records" :key="index">
          List item and some text #{{ index }}
        </div>
      </VaInfiniteScroll>
    </div>
  </div>
  <div>
    <TableInfo/>
    <AppBarTest />
    <DatePicker/>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
const value = ref(10)
const progressColor = computed(() => {
  return value.value <= 50 ? 'warning' : 'success'
})

// Increment and decrement functions
function valueplus() {
  value.value += 10
}

function valueless() {
  value.value -= 10
}
async function appendRecordsAsync() {
  await new Promise((resolve) => setTimeout(resolve, 1000))
  records.value.push({})
}
const records = ref([{}, {}, {}, {}, {}, {}, {}])
import AppBarTest from './components/AppBarTest.vue'
import TableInfo from './components/TableInfo.vue';
import DatePicker from './components/DatePicker.vue';
const userId = 1
</script>
