library(tidyverse)

temps <- read_csv("/home/mogs/Desktop/webdev_projects/vue_project/data/city_temperature.csv")
locs <- read_csv("/home/mogs/Desktop/webdev_projects/vue_project/data/country-capital-lat-long-population.csv")

locs <- rename(locs, City = `Capital City`) %>% select(-`Capital Type`, -Country)

head(temps)
head(locs)
unique(temps$Year)
temps <- temps %>% mutate(AvgTemperature = (AvgTemperature - 32)/1.8)

temps <- filter(temps, Year == 2019)
temps_summary <- temps %>%
  group_by(City) %>%
  summarise(YearAvg = sum(AvgTemperature)/n())

shared_cities <- intersect(locs$City, temps$City)
shared_cities

temps <- filter(temps, City %in% shared_cities)
locs <- filter(locs, City %in% shared_cities)

locs %>% jsonlite::toJSON(pretty = TRUE) %>% write_file("/home/mogs/Desktop/webdev_projects/vue_project/data/locs.json")
temps %>% jsonlite::toJSON(pretty = TRUE) %>% write_file("/home/mogs/Desktop/webdev_projects/vue_project/data/temps.json")
temps_summary %>% jsonlite::toJSON(pretty = TRUE) %>% write_file("/home/mogs/Desktop/webdev_projects/vue_project/data/temps_summary.json")
