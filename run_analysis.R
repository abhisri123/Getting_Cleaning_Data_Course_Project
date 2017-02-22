#**Peer-graded Assignment: Getting and Cleaning Data Course Project**
====================================================================
## By Abhinav

## *Loading and preprocessing the data*

# Download and unzip the file


fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,"Dataset.zip")
unzip("Dataset.zip")


# Read files in Data Frames


library(data.table)
library(dplyr)
library(plyr)
activity_labels<-read.table("activity_labels.txt")
features<-read.table("features.txt")


setwd("./train")
subject_train<-read.table("subject_train.txt")
X_train<-read.table("X_train.txt")
Y_train<-read.table("y_train.txt")


setwd("./Inertial_Signals")
body_acc_x_train<-read.table("body_acc_x_train.txt")
body_acc_y_train<-read.table("body_acc_y_train.txt")
body_acc_z_train<-read.table("body_acc_z_train.txt")

body_gyro_x_train<-read.table("body_gyro_x_train.txt")
body_gyro_y_train<-read.table("body_gyro_y_train.txt")
body_gyro_z_train<-read.table("body_gyro_z_train.txt")

total_acc_x_train<-read.table("total_acc_x_train.txt")
total_acc_y_train<-read.table("total_acc_y_train.txt")
total_acc_z_train<-read.table("total_acc_z_train.txt")


setwd("../")
setwd("../")
setwd("./test")

subject_test<-read.table("subject_test.txt")
X_test<-read.table("X_test.txt")
Y_test<-read.table("y_test.txt")

setwd("./Inertial_Signals")
body_acc_x_test<-read.table("body_acc_x_test.txt")
body_acc_y_test<-read.table("body_acc_y_test.txt")
body_acc_z_test<-read.table("body_acc_z_test.txt")

body_gyro_x_test<-read.table("body_gyro_x_test.txt")
body_gyro_y_test<-read.table("body_gyro_y_test.txt")
body_gyro_z_test<-read.table("body_gyro_z_test.txt")

total_acc_x_test<-read.table("total_acc_x_test.txt")
total_acc_y_test<-read.table("total_acc_y_test.txt")
total_acc_z_test<-read.table("total_acc_z_test.txt")


## *1. Merge the training and the test sets to create one data set.*

#-Merges Train Data using cbind
#-Merges Variables "Activity", "Subjects", 
#-Feature Data,
#-Inertial Signals (total_acc, body_acc, body_gyro in the order x,y,z)

trainData<-cbind(Y_train,subject_train,X_train,body_acc_x_train,body_acc_y_train,body_acc_z_train,body_gyro_x_train,body_gyro_y_train,body_gyro_y_train,total_acc_x_train,total_acc_y_train,total_acc_z_train)

#Similarly merge Test Data using cbind


testData<-cbind(Y_test,subject_test,X_test,body_acc_x_test,body_acc_y_test,body_acc_z_test,body_gyro_x_test,body_gyro_y_test,body_gyro_y_test,total_acc_x_test,total_acc_y_test,total_acc_z_test)

#Merge Train Data and Test Data using rbind and assign to totalData

totalData<-rbind(trainData,testData)

## *2. Extracts only the measurements on the mean and standard deviation for each measurement*

#-From the "features Data" Frame, extract those features as TRUE which has mean and standard deviation in it using grepl function
#-Extract these columns from totalData and assign to totalData_mean_std 

totalData_mean_std<-totalData[,c(rep(FALSE,times=2),(grepl("std",features$V2)|grepl("mean",features$V2)),rep(FALSE,times=128*9))]

## *3. Uses descriptive activity names to name the activities in the data set*

#Merge "totalData" and "activity_labels" to get descriptive activity names


totalData_Activity<-merge(totalData,activity_labels,by.x=1,by.y=1,all=TRUE)

## 4. Appropriately labels the data set with descriptive variable names. 

#-Var1: ActivityCode
#-Var2: SubjectCode
#-Var3 to Var 563: Features
#-Var564 to Var 1715: Inertial Signals
#-Var1716: ActivityLabels

colnames(totalData_Activity)<-c("ActivityCode","SubjectCode",as.character(features$V2),paste("body_acceleration_x",1:128),paste("body_acceleration_y",1:128),paste("body_acc_z",1:128),paste("body_gyro_x",1:128),paste("body_gyro_y",1:128),paste("body_gyro_z",1:128),paste("total_acceleration_x",1:128),paste("total_acceleration_y",1:128),paste("total_acceleration_z",1:128),"ActivityLabels")

#-Identify and rename duplicate variables
#-Identify and rename variables containing special characters

names(totalData_Activity)[duplicated(names(totalData_Activity))]<-paste(names(totalData_Activity)[duplicated(names(totalData_Activity))],rep(1:2,each=14,times=3))
names(totalData_Activity)<-make.names(names(totalData_Activity),unique=TRUE)

## *5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.*
#-Assign "totalData_activity" with removed last column to "totalData1" 
#-melt Data with id as ActivityCode and SubjectCode and rest of the measurments as Variables
#-dcast the melted Data with mean of melted columns on ActivityCode+SubjectCode and save in another tidy data "finalData"

totalData1<-totalData_Activity[,1:1715]
meltData<-melt(totalData1,id=c("ActivityCode","SubjectCode"),measure.vars=3:1715)
finalData<-dcast(meltData,ActivityCode+SubjectCode~variable,mean)

#Write the data to file "finalTidyData.txt" with row.names = FALSE

write.table(finalData,file="finalTidyData.txt",row.names=FALSE)


## *End of File*