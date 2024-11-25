export function getTemperatureColor(avgTemp) {
    const minTemp = -15; 
    const maxTemp = 30; 
  
    // Normalize temperature value
    const normalizedTemp = (avgTemp - minTemp) / (maxTemp - minTemp);
    
    const red = Math.min(255, Math.floor(255 * normalizedTemp));
    const blue = Math.min(255, Math.floor(255 * (1 - normalizedTemp)));
  
    return `rgb(${red}, 0, ${blue})`;
  }