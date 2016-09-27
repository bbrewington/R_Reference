# k-Nearest Neighbor CLASSIFICATION example
# from Jalayer Academy's Youtube tutorial:
#   part 1: https://youtu.be/GtgJEVxl7DY?list=PLjPbBibKHH18I0mDb_H4uP3egypHIsvMn
#   part 2: https://youtu.be/DkLNb0CXw84?list=PLjPbBibKHH18I0mDb_H4uP3egypHIsvMn

data(iris)

table(iris$Species)
head(iris)
iris # data is sorted by Species; need to randomize order?
set.seed(9850)
gp <- runif(nrow(iris))
iris <- iris[order(gp),]
str(iris)
head(iris)
summary(iris[,1:4])

normalize <- function(x){
  return( (x - min(x)) / (max(x) - min(x)))
}
normalize(1:5)
normalize(c(10, 20, 30, 40, 50))

iris_n <- as.data.frame(lapply(iris[,1:4], normalize))
iris_n
summary(iris_n)

iris_train <- iris_n[1:129, ]
iris_test <- iris_n[130:150, ]
iris_train_target <- iris[1:129, 5]
iris_test_target <- iris[130:150, 5]

require(class)
sqrt(150) # square root of total number of observations; use odd number to take ties into account
k <- 13
m1 <- knn(train = iris_train, test = iris_test, cl = iris_train_target, k = 13)
table(iris_test_target, m1)
