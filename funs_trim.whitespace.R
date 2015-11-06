## 3 different functions for trimming whitespace from vectors in R
## Thanks to github user f3lix for these functions (link to profile: profile: http://stackoverflow.com/users/60617/f3lix)
## source: http://stackoverflow.com/questions/2261079/how-to-trim-leading-and-trailing-whitespace-in-r

# returns string w/o leading whitespace
trim.leading <- function (x)  sub("^\\s+", "", x)

# returns string w/o trailing whitespace
trim.trailing <- function (x) sub("\\s+$", "", x)

# returns string w/o leading or trailing whitespace
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
