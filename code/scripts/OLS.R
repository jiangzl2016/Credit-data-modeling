#perform ordinary linear regression
scaled_credit <- read.csv("../../data/scaled_credit.csv", stringsAsFactors=FALSE)
scaled_credit = scaled_credit[,-1]
load("../../data/training_and_testing.RData")

# OLS in training set
ols_model = lm(Balance~ . , data = training_set)
ols_model_summary = summary(ols_model)

y_hat = predict(ols_model, x_testing)
ols_MSE = mean((y_hat - y_testing)^2)


# Refit the model:
model <- lm(Balance ~ .,data = scaled_credit)
OLS_summary <-summary(model)
sink('../../data/regression_models_output.txt')
cat('\n')
cat('OLS model summary \n')
print(ols_model_summary)
cat('\n')
sink()

save(ols_MSE, OLS_summary, file='../../data/OLS.RData')

png(file = "../../images//residual-plot.png")
plot(ols_model, which = 1)
dev.off()

png(file = "../../images/normal-qq-plot.png")
plot(ols_model, which = 2)
dev.off()

png(file = "../../images/scale-location-plot.png")
plot(ols_model, which = 3)
dev.off()





