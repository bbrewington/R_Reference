# Exercise source: http://r-exercises.com/2016/12/14/hierarchical-clustering-solutions-beginner/

library(ggmap)
capitals <- c("Albania, Tirana", "Andorra, Andorra la Vella", "Armenia, Yerevan", "Austria, Vienna", "Azerbaijan, Baku", "Belarus, Minsk", "Belgium, Brussels", "Bosnia and Herzegovina, Sarajevo", "Bulgaria, Sofia", "Croatia, Zagreb", "Cyprus, Nicosia", "Czech Republic, Prague", "Denmark, Copenhagen", "Estonia, Tallinn", "Finland, Helsinki", "France, Paris", "Germany, Berlin", "Greece, Athens", "Georgia, Tbilisi", "Hungary, Budapest", "Iceland, Reykjavik", "Italy, Rome", "Latvia, Riga", "Kazakhstan, Astana", "Liechtenstein, Vaduz", "Lithuania, Vilnius", "Luxembourg, Luxembourg", "Macedonia, Skopje", "Malta, Valletta", "Moldova, Chişinău", "Monaco, Monaco-Ville", "Montenegro, Podgorica", "Netherlands, Amsterdam", "Norway, Oslo", "Poland, Warsaw", "Portugal, Lisbon", "Republic of Ireland, Dublin", "Romania, Bucharest", "Russia, Moscow", "San Marino, San Marino", "Serbia, Belgrade", "Slovakia, Bratislava", "Slovenia, Ljubljana", "Spain, Madrid", "Sweden, Stockholm", "Switzerland, Bern", "Turkey, Ankara", "Ukraine, Kiev", "United Kingdom, London", "Vatican City, Vatican City")
theData <- geocode(capitals)
rownames(theData) <- capitals

theData_scaled <- scale(theData)

#Exercise 1
#Calculate the Euclidean latitude/longitude distances between all pairs of capital cities.

distance <- dist(theData_scaled)

#Exercise 2
#Use the obtained distances to produce the hierarchical clustering dendrogram object. Use all the default parameters.
#NOTE: By default the clusters will be merged together using the maximum possible distance between all pairs of their elements (this fact will be useful later).

dendrogram <- hclust(distance, method = "ward.D2")

# Exercise 3
# Visualize the obtained hierarchical clustering dendrogram.

plot(dendrogram)

# Exercise 4
# In the previous step the leaves of our dendrogram were placed at different heights. Let’s redo the plot so that all capital names are written at the same level.

plot(dendrogram, hang = -1)

# Exercise 5
# Hierarchical clustering procedure builds a hierarchy of clusters. One advantage of this method is that we can use the same dendrogram to obtain different numbers of groups.
# Cluster the European capitals into 3 groups.

cutree_k3 <- cutree(dendrogram, k = 3)

# Exercise 6
# Instead of specifying the wanted number of groups we can select the dendrogram height where the tree will be partitioned into groups. Since we used the maximum linkage function (default in exercise 2) this height has a useful interpretation – it ensures that all elements within one cluster are not more than the selected distance apart.
# a) Cluster the European capitals by cutting the tree at height=20.
# b) Plot the dendrogram and visualize the height at which the tree was cut into groups using a line.

cutree_h20 <- cutree(dendrogram, h = 20)
plot(dendrogram, hang = -1)
abline(a = 2, b = 0, col = "red")
rect.hclust(dendrogram, h = 2)

# Exercise 7
# Now visualize the clustering solution obtained in the 5th exercise on the dendrogram plot. This should be done by drawing a rectangle around all capitals that fall in the same group. Use different colors for different groups.

plot(dendrogram, hang=-1)
rect.hclust(dendrogram, k=3, border=1:3)

# Exercise 8
# Visualize the dendrogram again but this time present both cluster versions obtained in exercise 5 and exercise 6 on the same plot. Use red color to represent exercise 5 clusters and blue to represent clusters from exercise 6.

plot(dendrogram, hang=-1)
rect.hclust(dendrogram, k=3, border="red")
rect.hclust(dendrogram, h=2, border="blue")

# Exercise 9
# The hclust function has 8 implemented different linkage methods – methods used to merge two clusters when building the dendrogram. We want to experiment with all of them.
# Produce a dendrogram, obtain 5 groups and vizualize them using different color rectangles. Repeat this for all available linkage methods.



# Exercise 10
# Design your own clustering solution based on what you learned in this exercise and visualize it as a map.
# Plot capital coordinates with longitude on the x-axis and latitude on the y-axis and color them based on the groups obtained using your hierarchical clustering version.

myVersion <- hclust(distance, method="complete")
groups    <- cutree(myVersion, 7)
plot(theData_scaled, cex=0, xlim=c(-30,75))
text(theData_scaled, rownames(theData_scaled), cex=0.6, col=groups)

m <- get_map("Prague, Czech Republic", zoom = 3)
groups <- cutree(dendrogram, k = 5)
df <- as.data.frame(theData_scaled) %>% rename(lon_scaled = lon, lat_scaled = lat) %>%
  mutate(group = groups) %>% mutate(lon = theData$lon, lat = theData$lat)
ggmap(m) + geom_point(data = df, aes(x = lon, y = lat, color = factor(group)), size = 2)

df <- 
  df %>% left_join(
    df %>% group_by(group) %>% summarise(lon_scaled_centroid = mean(lon_scaled), 
                                         lat_scaled_centroid = mean(lat_scaled),
                                         lon_centroid = mean(lon),
                                         lat_centroid = mean(lat)),
    by = "group")

centroid_scaled_unique <- df %>% select(lat_scaled_centroid, lon_scaled_centroid) %>% distinct()

#### Functions for unscaling lat/lon ####
lon_unscaled <- function(x){
  x * attr(theData_scaled, "scaled:scale")[1] + attr(theData_scaled, "scaled:center")[1]
}

lat_unscaled <- function(x){
  x * attr(theData_scaled, "scaled:scale")[2] + attr(theData_scaled, "scaled:center")[2]
}

#### Do K Means clustering using the Ward.D2 as a seed ####
kmeans1 <- kmeans(df[,1:2], centers = 5, iter.max = 20)
ggmap(m) + 
  geom_point(data = df, aes(x = lon, y = lat, color = factor(kmeans1$cluster))) +
  geom_point(data = as.data.frame(kmeans1$centers) %>% 
               mutate(lon = lon_unscaled(lon_scaled), lat = lat_unscaled(lat_scaled)),
             aes(x = lon, y = lat),
             color = "black")
