# Getting and Cleaning Data Course Project
Ashly Yashchin
## Description
Details surrounding variables indicated, summaries calculated and other relevant information relating to the project and script.
## Source Data
Information surrounding the full source data for this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
The source data can be found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
## Data Set Information
#### As taken from the source data ReadMe.txt.
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 
## Attribute Information
For each record in the data set it is provided:
*Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
*Triaxial Angular velocity from the gyroscope. 
*A 561-feature vector with time and frequency domain variables. 
*Its activity label. 
*An identifier of the subject who carried out the experiment.
## Performing the Analysis
### 1) Setting up the Workplace
Install (if necessary) and load dplyr and reshape2 packages.
### 2) Download and Unzip the Source Data
Check if already installed, download the data and unzip files into HARzip filename.
### 3) Create Activity Variables List
Read in activity_labels.txt from Harzip[1]:
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING
Assign to new variable: activity_variables
### 4) Create Subset Filter for Mean & Standard Deviation
Read in features.txt from Harzip[2].
Use grep to find and create new variable: desired_measures, corresponding to the listed mean and standard deviation labels, denoted by mean() and std() in the source data.
### 5)Read Text Files into a List & Convert to Data Tables
Use lapply to create a list of the HARzip files containing observations and convert to data tables for use with dplyr package.
### 6)Merge Subject & Activity Data into One Set
Using the desired_measures variable as a subset filter for X_test.txt and X-train.txt data, create two clean data sets for testing and training data, labeled: clean_data_test and clean_data_train respectively.
Merge both sets using rbind function. 
### 7)Add Descriptive Labels for Table
Convert activity column to factor and use activity_variables to assign corresponding labels in the data table.
Convert subject to factor for use in final tidy data set.
Arrange by subject, then activity in descending order and assign to new variable: clean_merge.
### 8) Create New Tidy Data Set Showing Means for Each Subject by Activity
Melt the data using Subject and Activity as factors. Assign to final variable: tidy_data.
Group data on subject, then activity using dplyr group_by function. 
Use dplyr summarize function to calculate the mean for each variable for each activity and each subject. 
Print tidy_data set.
