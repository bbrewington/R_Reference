zoom_level_map <- function(min.zoom = 10, max.zoom = 14, city, state, view.zoom = min.zoom,
                           output.file.width = 11, output.file.height = 11){
     require(dplyr)
     require(ggmap)
     
     zoomvec <- min.zoom:max.zoom
     output <- vector("list", length = length(zoomvec))
     
     for(i in 1:length(zoomvec)){
          map <- get_map(paste(city, state, sep = ", "), zoom = zoomvec[i])
          output[[i]] <- cbind(attr(map, "bb"), zoom = zoomvec[i])
     }
     
     df <- bind_rows(output)
     
     citymap <- get_map(paste(city, state, sep = ", "), 
                        zoom = view.zoom, maptype = "roadmap")
     
     p <- ggmap(atlanta) +
          geom_rect(data = df, aes(xmin = ll.lon, ymin = ll.lat, 
                                   xmax = ur.lon, ymax = ur.lat, 
                                   color = factor(zoom)), 
                    alpha = 0, size = 2, inherit.aes = FALSE) +
          scale_color_brewer(type = "qual", palette = "Set1", name = "Zoom Level") +
          ggtitle(paste0("Google Maps API: Zoom Levels for ", city, ", ", state))
     
     ggsave(filename = paste0(city, ".zoom.levels.png"), plot = p, 
            width = output.file.width, height = output.file.height)
     
     print(p)
}

