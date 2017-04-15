require(dplyr)

tidyData <- function() {
  getDataSet()
  loadActivityAndFeatures()
  dtTrain <- dt_loadTrain()
  dtTest <- loadTrain()
  dataset <- mergeData(dtTest, dtTrain)
  nameVariables(dataset)
}

getDataSet <- function() {
  if(!dir.exists("./UCI HAR Dataset/")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "dataset.zip")
    unzip("dataset.zip")
  }
}

loadActivityAndFeatures <- function() {
  activityLabels <<- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "Activities"))
  activityLabels[,2] <- as.character(activityLabels[,2])
  features <<- read.table("UCI HAR Dataset/features.txt")
  features[,2] <- as.character(features[,2])
}

loadTests <- function() {
  subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c("Subject"))
  xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
  colnames(xTest) <- features[,2]
  yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
  yTest <- activityLabels[match(yTest$V1, activityLabels$id), 2, drop = F]
  
  cbind(subjectTest, yTest, xTest)
}

loadTrain <- function() {
  subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c("Subject"))
  xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
  colnames(xTrain) <- features[,2]
  yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
  yTrain <- activityLabels[match(yTrain$V1, activityLabels$id), 2, drop = F]
  
  cbind(subjectTrain, yTrain, xTrain)
}

mergeData <- function(dtTests, dtTrain) {
  rbind(dtTests, dtTrain)
}

nameVariables <- function(dataset) {
  names(dataset) <- gsub("\\(","",names(dataset))
  names(dataset) <- tolower(dataset)
}

datasetAverage <- function() {
  ## TODO : MB
}
