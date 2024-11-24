<script setup>
</script>

<template>
  <div class="greetings">
    <h1 class="green">Capital city temperature dashboard</h1>
    <h3>
      Capital cities and their average temperatures in 2019.
    </h3>
    <h3>Built using Vue.js</h3>
  </div>
</template>

<style scoped>
h1 {
  font-weight: 500;
  font-size: 2.6rem;
}

h3 {
  font-size: 1.2rem;
}

.greetings h1,
.greetings h3 {
  text-align: center;
  gap: 0.3rem;
}

@media (min-width: 1024px) {
  .greetings h1,
  .greetings h3 {
    text-align: left;
  }
}

@media (max-width: 780px) {
  .greetings h1 {
    font-size: 1.5rem;

  }

  .greetings h3 {
  font-size: 1rem;
}
}
</style>
