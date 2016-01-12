library(rvest)
page <- "fill in website here"
page.html <- read_html(page)

# Extract element with html_text()
page.html %>% html_node("ENTER CSS SELECTOR HERE") %>% html_text()
