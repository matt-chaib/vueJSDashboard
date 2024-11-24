<template>
  <div>
    <div id="map" style="width: 100%; height: 500px"></div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import locationData from "../data/locs.json";
import tempData from "../data/temps_summary.json";
let tempDataClean = tempData.filter((city) => city.City !== "Islamabad");


import { useCityStore } from "@/stores/cityStore";

const cityStore = useCityStore();

// Access the selected city
const selectedCity = cityStore.selectedCity;

// Set a new city
const selectCity = (city) => {
  cityStore.setSelectedCity(city);
};

const map = ref(null); // Reference for the map instance

// Function to load Google Maps script dynamically
const loadGoogleMapsScript = () => {
  return new Promise((resolve, reject) => {
    if (document.getElementById("google-maps-script")) {
      resolve(); // Script already loaded
      return;
    }

    const script = document.createElement("script");
    script.id = "google-maps-script";
    script.src = `https://maps.googleapis.com/maps/api/js?key=AIzaSyCMmcLmgk_WFZvoZ_zGCIXpyv2kJMFt7P8`;
    script.async = true;
    script.defer = true;
    script.onload = resolve;
    script.onerror = reject;

    document.head.appendChild(script);
  });
};

// Function to initialize the map
const initializeMap = () => {
  map.value = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 0, lng: 0 },
    zoom: 2,
  });

  function getTemperatureColor(avgTemp) {
  // Assuming temperature ranges from minTemp to maxTemp
  const minTemp = -15; // Example: minimum temperature
  const maxTemp = 30; // Example: maximum temperature

  // Normalize temperature value
  const normalizedTemp = (avgTemp - minTemp) / (maxTemp - minTemp);
  
  // Calculate color using a gradient from blue to red
  const red = Math.min(255, Math.floor(255 * normalizedTemp));
  const blue = Math.min(255, Math.floor(255 * (1 - normalizedTemp)));

  return `rgb(${red}, 0, ${blue})`;
}

  const populations = locationData.map((city) => city.Population);
  const minPop = Math.min(...populations);
  const maxPop = Math.max(...populations);
  let currentInfoWindow = null; // Variable to store the currently open InfoWindow

  locationData.forEach((city) => {
    // Normalize the population
    const normalizedPop = (city.Population - minPop) / (maxPop - minPop);

    // Scale the normalized population to the size range [10, 30]
    const size = 5 + normalizedPop * (30 - 5);
    const temp = tempDataClean.filter(data => data.City == city.City)[0]?.YearAvg

    let marker = new google.maps.Marker({
      position: { lat: city.Latitude, lng: city.Longitude }, // Example: Paris
      map: map.value,
      title: city.City,
      icon: {
        path: google.maps.SymbolPath.CIRCLE, // Circle shape
        fillColor: getTemperatureColor(temp), // Marker color
        fillOpacity: 1, // Full opacity
        strokeColor: "white", // Stroke around the circle
        strokeWeight: 2, // Stroke width
        scale: size,
      },
    });

    // Add click event listener to the marker
    marker.addListener("click", () => {
        // Create a new InfoWindow instance
const infoWindow = new google.maps.InfoWindow();

        if (currentInfoWindow) {
    currentInfoWindow.close();
  }
        selectCity(city.City)
      // Content to display inside the InfoWindow
      const content = `<div><h3>${marker.getTitle()}</h3><p>Population: ${
        city.Population
      }</p><p>Yearly Avg Temp: ${temp} Celsius</p></div>`;

      // Set the content of the InfoWindow
      infoWindow.setContent(content);

      // Set the position of the InfoWindow
      infoWindow.setPosition(marker.getPosition());

      // Open the InfoWindow at the marker's position
      infoWindow.open(map.value, marker);

      currentInfoWindow = infoWindow;

    });
  });
};

// Lifecycle hook to initialize the map after the component is mounted
onMounted(() => {
  loadGoogleMapsScript()
    .then(initializeMap)
    .catch((error) => {
      console.error("Error loading Google Maps script:", error);
    });
});
</script>

<style>
/* Optional styling for the map */
#map {
  border: 1px solid #ccc;
  border-radius: 8px;
}
</style>
