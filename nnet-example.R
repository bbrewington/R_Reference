# Simple example of nnet
# source: https://www.r-bloggers.com/neural-networks-exercises-part-1/

library(dplyr); library(nnet)

# Generate random vector x and target vector y and combine into data frame df
set.seed(42)
x <- round(runif(n = 200, min = -10, max = 10))
y <- sin(x)
df <- data.frame(i = 1:200, x, y)

set.seed(42)
weights <- runif(n = 22, min = -1, max = 1)

# Do a 75/25 split into train/test
set.seed(42)
df.train <- df %>% sample_frac(size = .75)
df.test <- df %>% filter(!(i %in% df.train$i))

# Train a model and inspect
model1 <- nnet(Wts = weights, x = df.train$x, y = df.train$y, 
               linout = TRUE, maxit = 100, size = 7)
str(model1)

# Generate predictions, calculate RMSE, and plot
predict.model1 <- predict(model1, df.test %>% select(x))
rmse <- sqrt(sum((df.test$y - predict.model1)^2))
plot(sin, -10, 10)
points(df.test$x, predict.model1)
