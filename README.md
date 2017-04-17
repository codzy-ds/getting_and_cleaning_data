# Getting and Cleaning Data final project

This repository contains the final project for the course Getting and Cleaning Data.

## Explanation of the script

The repository contains the script run_analysis.R which download the dataset :

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The begining of the script is the function tidyData which will call the other functions to

* Read the train and tests datasets
* Assign the Activities labels
* Assign the column names
* Filter the columns to keep only mean and standard deviation
* Rename the columns to have something a little bit more understandable
* Create a second dataset with the average of each varable for each subject and each activity.

The dataset are written in file "mean_and_std_tidy.txt" for the first tidy dataset and "average_dataset.txt" for the average of each varable dataset.
