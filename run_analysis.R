require(dplyr)

tidyData <- function() {
  getDataSet()
  activityLabels <<- loadActivity()
  features <- loadFeatures()
  dtTrain <- loadTrain(features[,2])
  dtTest <- loadTrain(features[,2])
  dataset <- mergeData(dtTest, dtTrain)
  dataset <- writeTidy(dataset)
  extractMeanAndStdDeviation(dataset)
}

getDataSet <- function() {
  if(!dir.exists("./UCI HAR Dataset/")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "dataset.zip")
    unzip("dataset.zip")
  }
}

loadActivity <- function() {
  activityLabels <<- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "Activities"))
  activityLabels[,2] <- as.character(activityLabels[,2])
  activityLabels
}

loadFeatures <- function() {
  features <- read.table("UCI HAR Dataset/features.txt")
  features[,2] <- as.character(features[,2])
  features[,2] <-  gsub("-", "", features[,2])
  features[,2] <-  gsub("\\()", "", features[,2])
  features[,2] <- gsub("\\,", "", features[,2])
  features[,2] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",features[,2])
  features[,2] <- gsub("Mag","Magnitude",features[,2])
  features[,2] <- gsub("mean","Mean",features[,2])
  features[,2] <- gsub("std","Std",features[,2])
  features
}

loadTests <- function(variables) {
  subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c("Subject"))
  xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
  colnames(xTest) <- variables
  yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
  yTest <- activityLabels[match(yTest$V1, activityLabels$id), 2, drop = F]
  
  cbind(subjectTest, yTest, xTest)
}

loadTrain <- function(variables) {
  subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c("Subject"))
  xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
  colnames(xTrain) <- variables
  yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
  yTrain <- activityLabels[match(yTrain$V1, activityLabels$id), 2, drop = F]
  
  cbind(subjectTrain, yTrain, xTrain)
}

mergeData <- function(dtTests, dtTrain) {
  rbind(dtTests, dtTrain)
}

writeTidy <- function(dataset) {
  meanstdCols <- (grepl("Mean|Std", colnames(dataset)) | grepl("Activities", colnames(dataset)) | grepl("Subject", colnames(dataset)))
  meanStd <- dataset[,meanstdCols]
  write.table(meanStd, "mean_and_std_tidy.txt")
  meanStd
}

extractMeanAndStdDeviation <- function(dataset) {
  averageDataset <- aggregate(. ~Subject + Activities, dataset, mean)
  write.table(averageDataset, "average_dataset.txt")
}
