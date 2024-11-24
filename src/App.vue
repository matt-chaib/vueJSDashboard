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
  margin: 2rem 1rem;
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
</style>
