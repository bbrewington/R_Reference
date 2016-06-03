# from https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html

library(httr)

url <- "http://httpbin.org/get"

# GET regular call
r <- GET(url)

# GET regular call
r <- stop_for_status(GET(url))

# GET call w/ headers 
r <- GET(url, add_headers(a = 1, b = 2))

# GET call w/ query
r <- GET("http://google.com/", path = "search", query = list(q = "ham"))

headers(r)
content(r)
status_code(r)
