## pareto.chart
## input: data frame with categorical column "subject" and numeric column "count"
## output: ggplot bar plot ordered descending by "count", with remaining values combined into bar at end
pareto.chart <- function(data, top_n, plot_title = "Pareto Chart"){
  require(ggplot2)
  require(dplyr)
  
  if(!("subject" %in% names(data)) | !("count" %in% names(data))){
    stop("data frame input must contain columns subject and count")
  }
  
  # Sort descending by "count"
  data <- data %>% arrange(desc(count)) %>% filter(!is.na(subject))
  # Filter to top N values
    # Combine data from rows outside of top N, and calculate the sum of "count"
    #data.bottom.combine.data <- data %>% mutate(rank = dense_rank(count)) %>% filter(rank <= max(dense_rank(count)) - 10)
    data.bottom.combine <- as.numeric(data %>% mutate(rank = dense_rank(count)) %>% 
                                      filter(rank <= max(dense_rank(count)) - top_n) %>% 
                                      summarise(sum(count)))
  
  data.pareto <- data %>% mutate(rank = dense_rank(count)) %>% filter(rank > max(dense_rank(count)) - top_n)
  
  # add OTHER VALUES row to data.pareto (warnings suppressed because "OTHER VALUES" is not a factor
  data.pareto <-  suppressWarnings(bind_rows(data.pareto, data.frame(subject = "OTHER VALUES", count=data.bottom.combine)))
  
  #Calculate cumulative percent
  data.pareto <- data.pareto %>% mutate(cuml.pct = cumsum(count) / sum(count))
  
  ggplot(data.pareto, aes(subject,count)) +
    geom_bar(stat="identity") + 
    scale_x_discrete(limits = data.pareto$subject) + 
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
    geom_text(aes(label=count), vjust=-0.25) + 
    ggtitle(plot_title)
}
