library(pls)
load("../../data/training_and_testing.RData")
x=model.matrix(Balance ~.,training_set)[ ,-1]
y=training_set$Balance

#fit pcr model
pcr_fit <- pcr(Balance~., data = training_set, scale = FALSE, validation ="CV")
pcr_best <- which.min(pcr_fit$validation$PRESS)
sink('../../data/pcr_summary.txt')
summary(pcr_fit)
cat("\n The lowest MSE: \n")
print(min(pcr_fit$validation$PRESS))
cat("\n which corresponds to using 12 components")
sink()

y_hat = predict(pcr_fit, x, ncomp = pcr_best)
pcr_mse = mean((y_hat - y)^2)

png("../../images/validation_plot.png")
validationplot(pcr_fit, val.type = "MSEP")
dev.off()

#select the first two principle component
sink("../../data/PCR_on_full_dataset.txt")
scaled_credit <- read.csv("../../data/scaled_credit.csv", stringsAsFactors=FALSE)
x_full = model.matrix(Balance~., data = scaled_credit)[,-1]
y_full = scaled_credit$Balance
pcr.fit=pcr(y_full~x_full,scale=FALSE,ncomp=2)
pcr.coef = coef(pcr.fit)
cat("The summary table of PCR on fuull data set: \n")
print(summary(pcr.fit))
sink()

save(pcr_fit, pcr_best, pcr_mse,pcr.fit, pcr.coef, file = "../../data/pcr_fit.RData")
