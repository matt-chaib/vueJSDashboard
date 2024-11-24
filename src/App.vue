<script setup>
import Header from "./components/Header.vue";
import FactsPanel from "./components/FactsPanel.vue";
import GoogleMap from "./components/GoogleMap.vue";
import DetailedView from "./components/DetailedView.vue";

</script>

<template>
  <header>
    <!-- <img alt="Vue logo" class="logo" src="./assets/logo.svg" width="125" height="125" />

    <div class="wrapper">
      <HelloWorld msg="You did it!" />
    </div> -->
    <div>
      <Header />
    </div>
  </header>

  <main>
    <!-- <TheWelcome /> -->
    <h3>Click a circle to select a city.</h3>

    <div class="map-and-facts">
      <GoogleMap />
      <FactsPanel />
    </div>
    <DetailedView city="selected_city"/>

  </main>
</template>

<style scoped>
header {
  line-height: 1.5;
}

.logo {
  display: block;
  margin: 0 auto 2rem;
}

.map-and-facts {
  display: grid;
  grid-template-columns: 3fr 1fr;
  margin: 0.5rem 1rem 2rem 0rem;
}

h3 {
    font-style: italic;
}

@media (min-width: 1024px) {
  header {
    display: flex;
    place-items: center;
    padding-right: calc(var(--section-gap) / 2);
  }

  .logo {
    margin: 0 2rem 0 0;
  }

  header .wrapper {
    display: flex;
    place-items: flex-start;
    flex-wrap: wrap;
  }
}

@media (max-width: 780px) {
  .map-and-facts {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}
}
</style>
