tidyData <- function() {
  getDataSet()
  loadActivityAndFeatures()
  dtTrain <- loadTrain()
}

getDataSet <- function() {
  if(!dir.exists("./UCI HAR Dataset/")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "dataset.zip")
    unzip("dataset.zip")
  }
}

loadActivityAndFeatures <- function() {
  activityLabels <<- read.table("UCI HAR Dataset/activity_labels.txt")
  activityLabels[,2] <- as.character(activityLabels[,2])
  features <<- read.table("UCI HAR Dataset/features.txt")
  features[,2] <- as.character(features[,2])
}

loadTests <- function() {
  subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
  yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
  
  cbind(subjectTest, yTest, xTest)
}

loadTrain <- function() {
  subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  xTrain <- read.table("./UCI HAR Dataset/test/X_train.txt")
  yTrain <- read.table("./UCI HAR Dataset/test/y_train.txt")
  
  cbind(subjectTrain, yTrain, xTrain)
}

mergeData <- function(dtTests, dtTrain) {
  ## TODO : MB
}

nameVariables <- function() {
  ## TODO : MB
}

datasetAverage <- function() {
  ## TODO : MB
}
