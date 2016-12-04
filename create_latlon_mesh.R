library(ggplot2)
library(dplyr)

SW_corner_lat = 33 + 36/60 + 7.16/3600
NE_corner_lat = 33 + 54/60 + 36.07/3600
SW_corner_lon = -(84 + 30/60 + 7.67/3600)
NE_corner_lon = -(84 + 13/60 + 57.38/3600)

mesh_resolution = .01
n_lat = (NE_corner_lat - SW_corner_lat) %/% mesh_resolution
n_lon = (NE_corner_lon - SW_corner_lon) %/% mesh_resolution
all_lat = seq(SW_corner_lat, NE_corner_lat, length.out = n_lat)
all_lon = seq(SW_corner_lon, NE_corner_lon, length.out = n_lon)

mesh = as.data.frame(expand.grid(lat = all_lat, lon = all_lon))

#### Plot Mesh ####
mesh %>%
     ggplot(aes(lon, lat)) + geom_point(size = .001)
