#Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#You should create one R script called run_analysis.R that does the following: 
#Merges the training (17:28,13:24) and the test (5:16,1:12) sets to create one data set. - DONE
#Extracts only the measurements on the mean and standard deviation for each measurement. - DONE
#Uses descriptive activity names to name the activities in the data set - DONE
#Appropriately labels the data set with descriptive variable names. - DONE
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. - DONE
  
#Setting Up The Workspace
install.packages("dplyr")
library(dplyr)
install.packages("reshape2")
library(reshape2)

#Download and Unzip Files
if(!file.exists("./data")){dir.create("./data")}
filedownload <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Datase.zip",destfile="./data/HARzip.zip")
HARzip <- unzip("./data/HARzip.zip")

#Trial Activity Variables List
activity_variables <- read.table(HARzip[1])

#Desired Measures Subset (Mean & SD)
features <- read.table(HARzip[2])
features[,2] <- as.character(features[,2])
desired_measures <- grep(".*mean.*|.*std.*",features[,2])
desired_names <- features[desired_measures,2]
desired_names <- gsub('-mean','Mean',desired_names)
desired_names <- gsub('-std','Std',desired_names)
desired_names <- gsub('[-()]','',desired_names)

# read txt files into a list (separator is a space)
data_list = lapply(HARzip[5:28], read.table)

#Convert data to data tables
data_tables <- lapply(data_list,tbl_df)

#Merge Subject & Activity Data into New Sets
Subject_Test <- rename(data_tables[[10]],Subject=V1)
Activity_Test <- rename(data_tables[[12]],Activity=V1)
clean_test <- data_tables[[11]][desired_measures]
clean_data_test <- cbind(Subject_Test,Activity_Test,clean_test)

Subject_Train <- rename(data_tables[[22]],Subject=V1)
Activity_Train <- rename(data_tables[[24]],Activity=V1)
clean_train <- data_tables[[23]][desired_measures]
clean_data_train <- cbind(Subject_Train,Activity_Train,clean_train)


#Merge Into One Table & Add Labels
clean_merge <- rbind(clean_data_test,clean_data_train)
colnames(clean_merge) <- c("Subject", "Activity", desired_names)
clean_merge$Activity <- factor(clean_merge$Activity, levels = activity_variables[,1],labels=activity_variables[,2])
clean_merge$Subject <- as.factor(clean_merge$Subject)
clean_merge <- arrange(clean_merge,Subject,desc(Activity))

#Create New Data Set w/Means for Activity & Subject
tidy_data <- melt(clean_merge)
tidy_data <- rename(tidy_data,Variable=variable,Observation=value)
tidy_data <- group_by(tidy_data,Subject,Activity,Variable)
tidy_data <- summarize(tidy_data,mean(Observation))

print(tidy_data)