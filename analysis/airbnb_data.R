require(tidyverse)
library(RColorBrewer)
require(leaflet)

## Creates a quick map with AirBnb Data

# Functions
addLegendCustom <- function(map, position, colors, labels, sizes, opacity = 0.5){
  colorAdditions <- paste0(colors, "; border-radius: 50%; width:", sizes, "px; height:", sizes, "px")
  labelAdditions <- paste0("<div style='display: inline-block; height: ", sizes, "px;margin-top: 4px;line-height: ", sizes, "px;'>", labels, "</div>")
  
  return(addLegend(map, position = position, colors = colorAdditions, labels = labelAdditions, opacity = opacity))
}

# Load data
setwd('~/proyectos/exploratory-data-analysis/turistificacion/')
file <- 'data/raw/airbnb/listings_airbnb-madrid_insideairbnb-datahippo_merged_con-barrio.csv'

df <- read_delim(file, ',')

# Create map
colors <- brewer.pal(n = length(unique(df$NOMDIS)), name = 'Set1')
factpal <- colorFactor(colors, df$NOMDIS)

m <- leaflet(data = df) %>%
  addTiles() %>%
  addCircleMarkers(~longitude, ~latitude,
                   radius=1,
                   color = ~factpal(NOMDIS),
                   stroke = TRUE,
                   fillOpacity = 0.6,
                   popup = ~as.character(name)
  ) %>%
  addLegend("bottomright", pal = factpal, values = ~NOMDIS,
            title = "Distritos Madrid",
            opacity = 1
  )

m %>% addProviderTiles(providers$CartoDB.Positron)


