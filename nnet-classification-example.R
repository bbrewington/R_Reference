# Simple example of nnet for Classification
# Source: http://www.r-exercises.com/2017/06/08/neural-networks-solutions-part-1/

library(dplyr); library(nnet)

data(iris)
iris.scaled <- 
  bind_cols(lapply(iris[,1:4], function(x) (x - mean(x)) / sd(x)), 
            iris %>% select(Species) %>% mutate(i = 1:150))

# Do a 75/25 split into train/test
set.seed(42)
iris.scaled.train <- iris.scaled %>% sample_frac(.75)
iris.scaled.test <- iris.scaled %>% filter(!(i %in% iris.scaled.train$i)) %>%
  select(-i)
iris.scaled.train <- iris.scaled.train %>% select(-i)

# Train a model and inspect
model2 <- nnet(formula = Species ~ ., data = iris.scaled.train,
                size = 7, linout = TRUE)

# Generate predictions, create confusion matrix, and calculate accuracy
predict.model2 <- predict(model2, newdata = iris.scaled.test[,1:4],
                          type = "class")
confusion.matrix <- table(data.frame(predict.model2, iris.scaled.test$Species))
accuracy <- sum(diag(confusion.matrix)) / sum(confusion.matrix)
