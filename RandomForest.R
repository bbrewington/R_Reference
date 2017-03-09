# Random Forest Template -----
# source: http://blog.yhat.com/posts/comparing-random-forests-in-python-and-r.html

# Simulate the data ----
x1=rnorm(1000)
x2=rnorm(1000,x1,1)
y=2*x1+rnorm(1000,0,.5)
df=data.frame(y,x1,x2,x3=rnorm(1000),x4=rnorm(1000),x5=rnorm(1000))

# Run the randomForest implementation
library(randomForest)
# Build a Random Forest Model ----
    # Before running, make sure dataset has all variables converted to numeric
    #  (for character variables, convert to factor then numeric)
rf1 <- 
  randomForest(
    y~.,            # target as a function of all predictors
    data=df,        # dataset
    ntree=50,       # per randomForest help docs: Number of trees to grow (default to 50ish)
    importance=TRUE # use TRUE when needing to do variable selection
    )

# Check which variables are important in the model ----
# For more reference info, see http://alandgraf.blogspot.com/2012/07/random-forest-variable-importance.html
importance(rf1,type=1)
