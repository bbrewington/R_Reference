## Find top storage hogs in a directory, and display metrics by directory

library(ggplot2)
library(dplyr)
library(treemap)

setwd("C:/Users/Brent/Dropbox/")

# Get vectors of all files & their sizes
parentdir_filelist <- list.files(recursive=TRUE)
parentdir_filesize <- file.size(list.files(recursive=TRUE))

# Get vector of names of directories in level 1
lvl1dir_namelist <- substr(parentdir_filelist, 1, 
       sapply(gregexpr("/", parentdir_filelist), head, 1) - 1)

# Assemble data frame of vectors shown above (size converted to megabyte)
parentdir_data <- data.frame(element = parentdir_filelist, 
                           size = parentdir_filesize / 2^20, 
                           lvl1dir = lvl1dir_namelist,
                           stringsAsFactors = FALSE)

# Create data frame, sum of size for each level 1 dir (format: data_frame {dplyr})
df_sizesummary <- as_data_frame(parentdir_data) %>% group_by(lvl1dir) %>% 
  summarise(totalsize = sum(size)) %>% arrange(desc(totalsize))

# Grab top 5 level 1 dir's and plot them
df_top5 <- df_sizesummary %>% top_n(5, totalsize)
ggplot(df_top5, aes(reorder(lvl1dir,-totalsize),totalsize)) + 
  geom_bar(stat="identity") + labs(title = getwd(), x = "level 1 dir (top 5)") +
  theme(axis.text.x=element_text(angle = 45, hjust = 1))

# Treemap of parent directory
treemap(parentdir_data, "lvl1dir", "size")