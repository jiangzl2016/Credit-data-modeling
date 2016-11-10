library(glmnet)
load("../../data/training_and_testing.RData")
# set lambda value
x=model.matrix(Balance ~.,training_set)[ ,-1]
y=training_set$Balance
cvfold = 10
grid=10^seq(10,-2,length=100)

ridge_mod <- cv.glmnet(x,y,alpha=0,lambda=grid, nfolds = cvfold)
save(ridge_mod, file = '../../data/all_ridge_mods.RData')
par(mfrow = c(1,1))
png('../../images/ridge_mod_mse.png')
plot(ridge_mod)
dev.off()
#lambda.min is the value of λ λ that gives minimum mean cross-validated error.
sink('../../data/ridge_coefficients.txt')
ridge_best_lambda <- ridge_mod$lambda.min
ridge_coef <- coef(ridge_mod, s = "lambda.min")
sink()
#The other λ saved is lambda.1se, which gives the most regularized model such that error is within one standard error of the minimum.
# ridge_mod$lambda.1se
# coef(ridge_mod, s = "lambda.1se")
# Caluculate mean square error on test set
y_test = testing_set$Balance
x_test = model.matrix(Balance ~.,testing_set)[,-1]
ridge_mod_pred <- predict(ridge_mod, s=ridge_mod$lambda.min, newx = x_test)
ridge_test_mse = mean((ridge_mod_pred - y_test)^2)
sink('../../data/ridge_coefficients.txt', append = TRUE)
cat('\n The Test mse is: \n')
print(ridge_test_mse)
cat("\n")
sink()

#On full dataset
scaled_credit <- read.csv("../../data/scaled_credit.csv", stringsAsFactors=FALSE)
x_full = model.matrix(Balance~., data = scaled_credit)[,-1]
y_full = scaled_credit$Balance
out1 = glmnet(x_full, y_full, alpha = 0)
result1 = predict(out1, type = "coefficients", s=ridge_mod$lambda.min)[1:12,]
sink("../../data/RR_on_full_dataset.txt")
cat("The coefficients of all predictors based on the best model on full dataset \n")
print(result1)
sink()

save(ridge_mod, ridge_best_lambda, ridge_test_mse, out1, ridge_coef, file = '../../data/all_ridge_mods.RData')
