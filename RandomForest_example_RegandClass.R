# Random Forest Example: Classification & Regression
# source: http://blog.yhat.com/posts/comparing-random-forests-in-python-and-r.html

library(randomForest); library(miscTools); library(readr)
library(dplyr); library(stringr); library(ggplot2)
library(tibble)

# Get sample data: Wine  Quality from UCI Machine Learning library
df <- 
  bind_rows(
    read_delim("http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv", 
               col_types = "nnnnnnnnnnni",
               delim = ";") %>%
      mutate(is_red = factor(0, levels = 0:1)),
  read_delim("http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv", 
             col_types = "nnnnnnnnnnni",
             delim = ";") %>%
    mutate(is_red = factor(1, levels = 0:1))
)

df$high_quality <- factor(ifelse(df$quality > 6, 1, 0))
df$quality <- factor(df$quality)
names(df) <- str_replace_all(names(df), " ", "_")

# Random split into Train (80% of rows) & Train (20%)
test_vec <- sample(1:nrow(df), round(nrow(df) * .2))
train_vec <- (1:nrow(df))[which(sapply(1:nrow(df), function(x) !(x %in% test_vec)))]
test <- df %>% slice(test_vec)
train <- df %>% slice(train_vec)

# Model 1: Classification
    # Pick all columns except for is_red and high_quality
      cols <- names(train)[1:12]
    # Run Model
      clf <- randomForest(factor(quality) ~ ., data=train[,cols], ntree=20, nodesize=5, mtry=9)
    # Confusion Matrix
      table(test$quality, predict(clf, test[cols]))
    # Accuracy
      sum(test$quality==predict(clf, test[cols])) / nrow(test)

# Display Variable Importance
importance(clf) %>% as.data.frame() %>% rownames_to_column("variable") %>% arrange(desc(MeanDecreaseGini))

# Model 2: Regression
    # Pick a few columns
      cols <- c('is_red', 'fixed_acidity', 'density', 'pH', 'alcohol')
    # Run Model
      rf <- randomForest(alcohol ~ ., data=train[,cols], ntree=20)
    # Evaluate Model: R Squared
      (r2 <- rSquared(test$alcohol, test$alcohol - predict(rf, test[,cols])))
      # [1] 0.6481
    # Evaluate Model: Mean Squared Error
      (mse <- mean((test$alcohol - predict(rf, test[,cols]))^2))
      # [1] 0.6358
    # Plot results of regression model
      p <- ggplot(aes(x=actual, y=pred),
                  data=data.frame(actual=test$alcohol, pred=predict(rf, test[,cols])))
      p + geom_point() +
        geom_abline(color="red") +
        ggtitle(paste("RandomForest Regression in R r^2=", r2, sep=""))
