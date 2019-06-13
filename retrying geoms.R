#  Example from r-bloggers, to see if I can get the  geoms to work:
# https://www.r-bloggers.com/my-commonly-done-ggplot2-graphs/


library(ggplot2)
set.seed(20141016)

data <- data.frame(x <- rnorm(1000, mean=6))
data$group1 <- rbinom(n = 1000, size =1 , prob =0.5)
data$y <- data$x * 5 + rnorm(1000)
data$group2 <- runif(1000) > 0.2

g <- ggplot(data, aes(x = x, y=y)) + geom_point()
g

# add color:
g + aes(colour=group1)

g + aes(colour = factor(group1))

g + aes(colour = group2)

# note that the variables have to have been in the data frame when g was first created;
# attaching a new column to 'data' and then referencing it would fail.

g + geom_smooth()        # this includes the standard error bands by default.

g + geom_smooth(se = FALSE)  # this turns them off.


# Faceting - You can do the same graph, conditioned on levels of a variable.

g + facet_wrap(~ group1)

g + facet_wrap(~ group2)


g + facet_wrap(group2 ~ group1)  + geom_smooth()  # look at two faceting variables.


# Spaghetti Plot with Overall Smoother - for longitudinal data.
# For this example I took code from StackOverflow to create some longitudinal data:
# http://stats.stackexchange.com/questions/76999/simulating-longitudinal-lognormal-data-in-r


library(MASS)
library(nlme)

### set number of individuals
n <- 200

### average intercept and slope
beta0 <- 1.0
beta1 <- 6.0

### true autocorrelation
ar.val <- .4

### true error SD, intercept SD, slope SD, and intercept-slope cor
sigma <- 1.5
tau0  <- 2.5
tau1  <- 2.0
tau01 <- 0.3

### maximum number of possible observations
m <- 10

### simulate number of observations for each individual
p <- round(runif(n,4,m))

### simulate observation moments (assume everybody has 1st obs)
obs <- unlist(sapply(p, function(x) c(1, sort(sample(2:m, x-1, replace=FALSE)))))

### set up data frame
dat <- data.frame(id=rep(1:n, times=p), obs=obs)

### simulate (correlated) random effects for intercepts and slopes
mu  <- c(0,0)
S   <- matrix(c(1, tau01, tau01, 1), nrow=2)
tau <- c(tau0, tau1)
S   <- diag(tau) %*% S %*% diag(tau)
U   <- mvrnorm(n, mu=mu, Sigma=S)

### simulate AR(1) errors and then the actual outcomes
dat$eij <- unlist(sapply(p, function(x) arima.sim(model=list(ar=ar.val), n=x) * sqrt(1-ar.val^2) * sigma))
dat$yij <- (beta0 + rep(U[,1], times=p)) + (beta1 + rep(U[,2], times=p)) * log(dat$obs) + dat$eij






