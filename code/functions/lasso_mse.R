lasso_mse <- function(best_lambda){
  scaled_credit <- read.csv("../../data/scaled_credit.csv", stringsAsFactors=FALSE)
  load("../../data/training_and_testing.RData")
  grid = 10^seq(10, -2, length = 100)
  lasso_cv = cv.glmnet(as.matrix(x_training), as.matrix(y_training), alpha=1, intercept = FALSE, lambda = grid,
                       standardize = FALSE)
  y_hat = predict(lasso_cv, s = best_lambda, newx = data.matrix(x_testing))
  r_squared = (y_testing - y_hat)^2
  lasso_mse = sum(r_squared)/length(r_squared)
  return (lasso_mse)
}