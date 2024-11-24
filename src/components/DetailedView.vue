<script setup>
import { computed, ref } from "vue";
import TemperatureLineChart from "./TemperatureLineChart.vue";
import tempDataFull from "../data/temps"; // Full dataset
import data from '../data/temps_summary.json'
let updatedData = data.filter(city => city.City !== "Islamabad")

import { useCityStore } from "@/stores/cityStore";

const cityStore = useCityStore();

// Access the selected city
const selectedCity = computed(() => cityStore.selectedCity);


// Filter the temperature data based on the selected city
const temperatureData = computed(() => {
  return tempDataFull.filter((row) => row.City === selectedCity.value);
});

const maxYearAvg = updatedData.reduce((max, obj) => (obj.YearAvg > max.YearAvg ? obj : max), updatedData[0]);
const minYearAvg = updatedData.reduce((min, obj) => (obj.YearAvg < min.YearAvg ? obj : min), updatedData[0]);
</script>

<template>
  <div>
    <h1>Selected City: {{ selectedCity }}</h1>

    <div v-if="temperatureData.length > 0">
      <!-- Pass the temperature data to the chart component -->
      <TemperatureLineChart :temperatureData="temperatureData" :maxYearAvg="maxYearAvg.YearAvg" :minYearAvg="minYearAvg.YearAvg" />
    </div>
    <div v-else>
      <p>No temperature data available for the selected city.</p>
    </div>
  </div>
</template>

<style scoped>
/* Add styles as needed */
</style>
