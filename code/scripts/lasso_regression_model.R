library(glmnet)

scaled_credit <- read.csv("../../data/scaled_credit.csv", stringsAsFactors=FALSE)
scaled_credit = scaled_credit[,-1]
load("../../data/training_and_testing.RData")

grid = 10^seq(10, -2, length = 100)
lasso_cv = cv.glmnet(as.matrix(x_training), as.matrix(y_training), alpha=1, intercept = FALSE, lambda = grid,
                     standardize = FALSE)
lasso_best_lambdabda = lasso_cv$lambda.min

png(file = "../../images/lasso-cv-errors.png")
plot(lasso_cv)
dev.off()

y_hat = predict(lasso_cv, s = lasso_best_lambdabda, newx = data.matrix(x_testing))
r_squared = (y_testing - y_hat)^2
lasso_mse = sum(r_squared)/length(r_squared)

x = data.matrix(scaled_credit[ ,-12])
y = data.matrix(scaled_credit[ ,12])


lasso_refit = glmnet(x, y, alpha = 1, lambda = grid, intercept = FALSE,standardize = FALSE)
lasso_coef = predict(lasso_refit, s = lasso_best_lambdabda, type = "coefficients")[1:12, ]


save(lasso_cv, lasso_best_lambdabda, lasso_mse, lasso_refit, lasso_coef, file = "../../data/lasso_model.RData")

sink(file = "../../data/lasso-output.txt")
cat("\nLasso Regression Model \n")
cat("Best Lambda")
lasso_best_lambdabda
cat("\nOfficial coefficients\n")
lasso_coef
cat("\ntest MSE\n")
lasso_mse
sink()


