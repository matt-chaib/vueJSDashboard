<script setup>
import { defineProps, computed } from "vue";
import { LineChart } from "vue-chart-3";
import { Chart as ChartJS, Title, Tooltip, Legend, LineElement, PointElement, LinearScale, CategoryScale, LineController } from "chart.js";

ChartJS.register(Title, Tooltip, Legend, LineElement, PointElement, LineController, LinearScale, CategoryScale);

const props = defineProps({
  temperatureData: Array,
  maxYearAvg: Number,
  minYearAvg: Number
});

const labels = computed(() =>
  props.temperatureData.map((entry) => `${entry.Month}/${entry.Day}`)
);

const MaxValuesArray = computed(() => new Array(365).fill(props.maxYearAvg)); // Array with 365 elements, all set to 0
const MinValuesArray = computed(() => new Array(365).fill(props.minYearAvg)); // Array with 365 elements, all set to 0

const dataset = computed(() => ({
  labels: labels.value,
  datasets: [
    {
      label: "Daily Avg Temperature (°C)",
      data: props.temperatureData.map((entry) => entry.AvgTemperature),
      borderColor: "rgba(255, 99, 132, 1)", // Line color
      backgroundColor: "rgba(255, 99, 132, 0.2)", // Point color
      borderWidth: 2,
      pointRadius: 3,
    },
    {
            type: 'line',
            label: 'Niamey (World maximum) Year Avg',
            data: MaxValuesArray.value,
            borderColor: "rgba(255, 20, 20, 0.4)", 
            backgroundColor: "rgba(255, 20, 20, 0.4)", // Point color
            pointRadius: 0,
        },
        {
            type: 'line',
            label: 'Minsk (World minimum) Year Avg',
            data: MinValuesArray.value,
            borderColor: "rgba(20, 20, 255, 0.4)",
            backgroundColor: "rgba(20, 20, 255, 0.4)",
            pointRadius: 0,
        }
  ],
}));

const options = {
  responsive: true,
  plugins: {
    legend: { display: true },
    tooltip: { enabled: true },
  },
  scales: {
    x: { title: { display: true, text: "Day of Year" } },
    y: { title: { display: true, text: "Temperature (°C)" },   min: -10,
    max: 50,
  },
}};
</script>

<template>
  <LineChart :chart-data="dataset" :chart-options="options" />
</template>

<style scoped>
</style>
