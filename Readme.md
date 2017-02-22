#**Peer-graded Assignment: Getting and Cleaning Data Course Project**
====================================================================
## By Abhinav

##Introduction
============
This exercise is in the domain of "Human Activity Recognition Using Smartphones Dataset"

The data is available from experiments for a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone. The sensor Signals obtained from accelrrometer and gyroscope (128 readings/window) is processed and partitioned into Train and Test dataset in the ration 70% and 30% respectively. For each window a number of features were obtained.

The code for this exercise is saved in following file:
- "run_analysis.R"

The codebook containing the details for each Variables used is provided in the following file:
- "Codebook.md"

The final Tidy Data Output is in following file:
- "finalTidyData.txt"

The R markdown file is in following file:
- "Readme1.Rmd"

The details of how overall project works including steps for Analysis is in the following file:
- "Readme.md"

##Analysis of Data
================

##Step 0. Loading and preprocessing the data*

The data was Downloaded from the given url and unzip the file

Read data provided in various features, train and test files in Data Frames using read.table() function.

##Step 1. Merge the training and the test sets to create one data set.

a) Merges Train Data using cbind
-Merges Variables "Activity", "Subjects", 
-Feature Data,
-Inertial Signals (total_acc, body_acc, body_gyro in the order x,y,z)


b) Similarly merge Test Data using cbind
-Merges Variables "Activity", "Subjects", 
-Feature Data,
-Inertial Signals (total_acc, body_acc, body_gyro in the order x,y,z)


c) Merge Train Data and Test Data using rbind and assign to totalData



## *Step 2. Extracts only the measurements on the mean and standard deviation for each measurement*

-From the "features Data" Frame, extract those features as TRUE which has mean and standard deviation in it using grepl function
-Extract these columns from totalData and assign to totalData_mean_std 


## *Step 3. Uses descriptive activity names to name the activities in the data set*

Merge "totalData" and "activity_labels" to get descriptive activity names


## *Step 4. Appropriately labels the data set with descriptive variable names.*

-Var1: ActivityCode
-Var2: SubjectCode
-Var3 to Var 563: Features names updated from features file
-Var564 to Var 1715: Inertial Signals appended with 1 to 128 for each set
-Var1716: ActivityLabels

-Identify and rename duplicate variables as 42 names of variables are found to be duplicate
-Identify and rename variables as many feature names are containing special characters


## *5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.*
-Assign "totalData_activity" with removed last column to "totalData1" 
-melt Data with id as ActivityCode and SubjectCode and rest of the measurments as Variables
-dcast the melted Data with mean of melted columns on ActivityCode+SubjectCode and save in another tidy data "finalData"


Write the data to file "finalTidyData.txt" which is output file with Tidy Data

## *End of File*