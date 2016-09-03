# Neural Network Tutorial
# From KDNuggets post - http://www.kdnuggets.com/2016/08/begineers-guide-neural-networks-r.html

library(ISLR)
library(neuralnet)
library(caTools)
data(College)
numruns <- 100
num.error <- vector("numeric", length = numruns)

maxs <- apply(College[,2:18], 2, max)
mins <- apply(College[,2:18], 2, min)
scaled.data <- as.data.frame(scale(College[,2:18],center = mins, scale = maxs - mins))
Private <- as.numeric(College$Private) - 1
data <- cbind(Private, scaled.data)
set.seed(i)
split = sample.split(data$Private, SplitRatio = 0.70)

# Split based off of split Boolean Vector
train <- subset(data, split == TRUE)
test <- subset(data, split == FALSE)
feats <- names(scaled.data)

# Concatenate strings
f <- paste(feats,collapse=' + ')
f <- paste('Private ~',f)
f <- as.formula(f)
nn <- neuralnet(f, data, hidden=c(10,10,10), linear.output=FALSE)
predicted.nn.values <- compute(nn, test[2:18])

# Check out net.result
print(head(predicted.nn.values$net.result))
predicted.nn.values$net.result <- sapply(predicted.nn.values$net.result,round,digits=0)
table(test$Private, predicted.nn.values$net.result)
num.error[i] <- length(which(test$Private != predicted.nn.values$net.result))
