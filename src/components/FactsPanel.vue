<script setup>
    import TemperatureCard from './TemperatureCard.vue';
    import data from '../data/temps_summary.json'
    let updatedData = data.filter(city => city.City !== "Islamabad")

    const maxYearAvg = updatedData.reduce((max, obj) => (obj.YearAvg > max.YearAvg ? obj : max), updatedData[0]);
    const minYearAvg = updatedData.reduce((min, obj) => (obj.YearAvg < min.YearAvg ? obj : min), updatedData[0]);

</script>

<template>
    <div class="fact-box">
        <TemperatureCard
      :temperature="maxYearAvg.YearAvg"
      :location="maxYearAvg.City"
      description="Highest average temperature"
    />
    <TemperatureCard
      :temperature="minYearAvg.YearAvg"
      :location="minYearAvg.City"
      description="Lowest average temperature"
    />
    </div>
</template>

<style scoped>
.fact-box {
    padding: 0rem 1rem;
    display: flex;
    gap: 0.5rem;
    flex-direction: column;
}
</style>