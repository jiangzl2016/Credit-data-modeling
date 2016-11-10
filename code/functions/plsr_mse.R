plsr_mse <- function(plsr_best){
  scaled_credit <- read.csv("../../data/scaled_credit.csv", stringsAsFactors=FALSE)
  load("../../data/training_and_testing.RData")
  set.seed(200)
  plsr_cv = plsr(Balance ~., data = data.frame(training_set), validation = "CV")
  plsr_best = which.min(plsr_cv$validation$PRESS)
  y_hat = predict(plsr_cv, x_testing, ncomp = plsr_best)
  plsr_mse = mean((y_hat - y_testing)^2)
  return (plsr_mse)
}