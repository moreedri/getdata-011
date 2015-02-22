# Create one R script called run_analysis.R that does the following:
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## Create a new set with the average of each variable for each activity and each subject.
#

library(dplyr)

# data set is available online, check README.md
# this script expects the data to be available in /data folder
# gitignore ensures that /data folder is not copied around
testPath <- paste(getwd(), "data/test", sep = "/")
trainPath <- paste(getwd(), "data/train", sep = "/")


# loading core data
xTest <- read.table(paste(testPath, "X_test.txt", sep = "/"))
yTest <- read.table(paste(testPath, "y_test.txt", sep = "/"))
xTrain <- read.table(paste(trainPath, "X_train.txt", sep = "/"))
yTrain <- read.table(paste(trainPath, "y_train.txt", sep = "/"))


# metadata: merge list of test subjects, use numbers as subject labels
testSubj <- read.table(paste(testPath, "subject_test.txt", sep = "/"))
testSubj <- mutate(testSubj, group = "test")
trainSubj <- read.table(paste(trainPath, "subject_train.txt", sep = "/"))
trainSubj <- mutate(trainSubj, group = "train")
## rbind test + train
subject <- rbind(testSubj, trainSubj)
colnames(subject) <- c("subject", "group")


# metadata: read activity labels and merge y data
labelActs <- read.table(paste(getwd(), "data/activity_labels.txt", sep = "/"))
## rbind test + train
activity <- rbind(yTest, yTrain)
activity <- merge(activity, labelActs, by=1)
activity <- transmute(activity, activity = V2)

# read feature labels and use with x data
labelFeat <- read.table(paste(getwd(), "data/features.txt", sep = "/"))
## rbind test + train
feature <- rbind(xTest, xTrain)
colnames(feature) <- labelFeat[, 2]
## retain only mean and standard dev from features
selectFeature <- feature[ ,c(grep("-mean|-std", colnames(feature)))]


# combine x,y with labels
# allData <- cbind(subject, activity, feature)
data <- cbind(subject, activity, selectFeature)


# summarise means by subject and activity
avgData <- summarise_each(group_by(data, group, subject, activity), funs(mean))


# save the resulting data set
write.table(avgData, file="FinalData.txt", row.names = FALSE)
