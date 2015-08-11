## Exploratory Data Analysis Example using dplyr & ggplot2
## World Bank Development Indicators: Fertility Data (for a list of countries)

library(dplyr)

# List of countries to plot
countries <- c("India", "China", "United States", "Russian Federation")

# Load fertility data from World Bank Development Indicators if not done already
if(!("fertility" %in% ls()) | (length(fertility$iso2c) == 0)){
  fertility <- WDI(indicator = "SP.DYN.TFRT.IN")
}

# Filter by vector list of countries
fertility_filtered <- fertility %>% filter(country %in% countries)

# Generate line plot
ggplot(fertility_filtered, aes(year, SP.DYN.TFRT.IN, color = country)) + geom_line() +
  ggtitle("Fertility Data by Country")
