library(pls)
scaled_credit <- read.csv("../../data/scaled_credit.csv", stringsAsFactors=FALSE)
scaled_credit = scaled_credit[,-1]
load("../../data/training_and_testing.RData")

plsr_cv = plsr(Balance ~., data = data.frame(training_set), validation = "CV")
summary(plsr_cv)

#cross-validation error plot:
png(file = "../../images/plsr-cv-errors.png")
validationplot(plsr_cv, val.type = "MSEP")
dev.off()

#selecting the best number of components in the model:
plsr_best = which.min(plsr_cv$validation$PRESS)

#test MSE:
y_hat = predict(plsr_cv, x_testing, ncomp = plsr_best)
plsr_mse = mean((y_hat - y_testing)^2)


#refitting:
plsr_refit = plsr(Balance ~., data = data.frame(scaled_credit), ncomp = plsr_best)
plsr_coef = coef(plsr_refit)

# save and output:
save(plsr_cv, plsr_best, plsr_mse, plsr_refit, plsr_coef, file = "../../data/plsr_model.RData")

sink(file = "../../data/plsr-output.txt")
cat("\n Partial Least Squares Regression Model \n")
cat("\n best number of components in model \n")
plsr_best
cat("\n Test MSE \n")
plsr_mse
cat("\n summary of plsr \n")
summary(plsr_refit)
sink()


