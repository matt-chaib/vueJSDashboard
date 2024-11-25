<template>
  <div>
    <div id="map"></div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import locationData from "../data/locs.json";
import tempData from "../data/temps_summary.json";
import { useCityStore } from "@/stores/cityStore";
import { getTemperatureColor } from "@/utils";

let tempDataClean = tempData.filter((city) => city.City !== "Islamabad");

const cityStore = useCityStore();

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
    script.src = `https://maps.googleapis.com/maps/api/js?key=AIzaSyDtEUyOX4GrbrrS5tYKT1jvMUWrHD43doI`;
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

  const populations = locationData.map((city) => city.Population);
  const minPop = Math.min(...populations);
  const maxPop = Math.max(...populations);

  let currentInfoWindow = null;

  locationData.forEach((city) => {
    // Normalize the population
    const normalizedPop = (city.Population - minPop) / (maxPop - minPop);

    // Scale the normalized population to the size range [10, 30]
    const size = 5 + normalizedPop * (30 - 5);

    // Get the temperature for the chosen city.
    const temp = tempDataClean.filter((data) => data.City == city.City)[0]
      ?.YearAvg;

    let marker = new google.maps.Marker({
      position: { lat: city.Latitude, lng: city.Longitude },
      map: map.value,
      title: city.City,
      icon: {
        path: google.maps.SymbolPath.CIRCLE,
        fillColor: getTemperatureColor(temp), 
        fillOpacity: 1,
        strokeColor: "white", 
        strokeWeight: 2,
        scale: size,
      },
    });

    // Infowindow opens on marker click
    marker.addListener("click", () => {
      const infoWindow = new google.maps.InfoWindow();

      if (currentInfoWindow) {
        currentInfoWindow.close();
      }
      selectCity(city.City);

      // Content to display inside the InfoWindow
      const content = `<div><h3>${marker.getTitle()}</h3><p>Population: ${
        city.Population
      }</p><p>Yearly Avg Temp: ${temp} Celsius</p></div>`;

      infoWindow.setContent(content);
      infoWindow.setPosition(marker.getPosition());
      infoWindow.open(map.value, marker);

      currentInfoWindow = infoWindow;
    });
  });
};

onMounted(() => {
  loadGoogleMapsScript()
    .then(initializeMap)
    .catch((error) => {
      console.error("Error loading Google Maps script:", error);
    });
});
</script>

<style scoped>
#map {
  border: 1px solid #ccc;
  border-radius: 8px;
  height: 500px;
  width: 100%;
}

@media (max-width: 780px) {
  #map {
    border: 1px solid #ccc;
    border-radius: 8px;
    height: 300px;
    width: 300px;
  }
}
</style>
