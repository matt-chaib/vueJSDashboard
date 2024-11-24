import { defineStore } from "pinia";

export const useCityStore = defineStore("cityStore", {
  state: () => ({
    selectedCity: null, // Shared state
  }),
  actions: {
    setSelectedCity(city) {
      this.selectedCity = city; // Update state
    },
  },
});
