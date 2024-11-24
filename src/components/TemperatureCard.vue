<template>
    <div class="temperature-card">
      <div class="left">
        <span class="big-number">{{ temperature.toFixed(1) }}°C</span>
      </div>
      <div class="right">
        <h3 class="title">{{ location }}</h3>
        <p class="description">{{ description }}</p>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    props: {
      temperature: {
        type: Number,
        required: true,
      },
      location: {
        type: String,
        required: true,
      },
      description: {
        type: String,
        default: "Average temperature",
      },
    },
  };
  </script>
  
  <style scoped>
  .temperature-card {
    display: flex;
    align-items: center;
    background-color: #f5f5f5;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 16px;
    color: #555;
    max-width: 400px;
    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
  }
  
  .left {
    flex: 1;
    text-align: center;
  }
  
  .big-number {
    font-size: 3rem;
    font-weight: bold;
    color: #2c3e50;
  }
  
  .right {
    flex: 2;
    padding-left: 16px;
  }
  
  .title {
    font-size: 1rem;
    margin: 0;
    color: #34495e;
  }
  
  .description {
    font-size: 1.2rem;
    color: #7f8c8d;
  }
  </style>
  