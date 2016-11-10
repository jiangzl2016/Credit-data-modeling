#read in the scaled data
scaled_credit = read.csv("../../data/scaled_credit.csv", stringsAsFactors=FALSE)
scaled_credit = scaled_credit[,-1]
#split into training and testing set
set.seed(200)
sample_size = 300
sample = sample(1:dim(scaled_credit)[1], sample_size, replace = FALSE)
training_set = scaled_credit[sample,]
testing_set = scaled_credit[-sample,]

#Setting Training and Testing Vectors

x_training = training_set[ ,-12]
y_training = training_set[ ,12]

x_testing = testing_set[ ,-12]
y_testing = testing_set[ ,12]


#Storing these vectors into RData
save(training_set, testing_set, x_training, y_training, x_testing, y_testing, file = '../../data/training_and_testing.RData')
