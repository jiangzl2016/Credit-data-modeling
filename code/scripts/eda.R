####################################################
##loads dataset
setwd(file.path(getwd()))
Credit <- read.csv("../../data/Credit.csv", stringsAsFactors=FALSE)
str(Credit)

#deal with quantitative variables
col_name <- c('Income', 'Limit', 'Rating', 'Cards', 'Age', 'Education', 'Balance')
#create summary table and save
sink("../../data/eda-output.txt")
for (i in col_name){
  cat('summary table of', i)
  print(summary(Credit[i]))
  cat("\n")
}
sink()
# plot histograms
path = '../../images/'
par(mfrow = c(1,1))
for (i in col_name){
  png(paste(path, i, '_histogram.png', sep = ''))
  hist(Credit[,i], main = paste(i, 'histogram'), xlab = i)
  dev.off()
}
#plot boxplots
for (j in col_name){
  png(paste(path, j, '_boxplot.png', sep = ''))
  boxplot(Credit[,j], horizontal = TRUE, main = paste(j, 'boxplot'))
  dev.off()
}

#qualitative variables
col_name_qual <- c('Gender', 'Student', 'Married', 'Ethnicity')
sink("../../data/eda-output.txt", append = TRUE)
for (i in col_name_qual){
  paste('frequnecy and proportion table of', i)
  print(table(Credit[,i]))
  print(prop.table(table(Credit[,i])))
  cat('\n')
}
#create bar-chart
for (i in col_name_qual){
  png(paste(path, i, '_barplot.png', sep = ''))
  barplot(table(Credit[,i]), main = paste(i, 'barplot'), xlab = i)
  dev.off()
}
#matrix of correlation
Credit_quant <- data.frame(Credit[col_name])
Credit_qual <- data.frame(Credit[col_name_qual])
sink("../../data/eda-output.txt", append = TRUE)
cat("\n")
cat('correlation matrix among quantitative variables')
print(cor(Credit_quant))
cat("\n")
sink()
#scatterplot matrix
png('../../images/scatterplot_matrix.png')
pairs(Credit_quant)
dev.off()
#aov
sink("../../data/eda-output.txt", append = TRUE)
cat("\n")
aov_result <- aov(Balance~ Income + Limit + Rating + Cards + Age + Education, data = Credit_quant)
print(summary(aov_result))
cat("\n")
sink()

#conditional boxplot
library(fields)
#Gender', 'Student', 'Married', 'Ethnicity
png('../../images/Balance_vs_Credit.png')
boxplot(Credit$Balance~Credit$Gender)
dev.off()
png('../../images/Balance_vs_Student.png')
boxplot(Credit$Balance~Credit$Student)
dev.off()
png('../../images/Balance_vs_Married.png')
boxplot(Credit$Balance~Credit$Married)
dev.off()
png('../../images/Balance_vs_Ethnicity.png')
boxplot(Credit$Balance~Credit$Ethnicity)
dev.off()
#####################################################
##Pre-modeling data processing

Credit_copy <- Credit
temp_credit <- model.matrix(Balance~ ., data = Credit_copy)
new_credit <- cbind(temp_credit[,-c(1,2)], Balance = Credit_copy$Balance)
##remember to save this object
## Mean clustering and Standardizing
scaled_credit <- scale(new_credit, center = TRUE, scale = TRUE)
write.csv(scaled_credit, file = "../../data/scaled_credit.csv")
