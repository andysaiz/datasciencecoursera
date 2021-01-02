---
title: "CodeBook.md"
author: "Andy"
date: "1/2/2021"
output: pdf_document
---

##Introduction

The purpose of this assignment obtain and tidy data from the Human Activity Recognition Using Smartphones Dataset
Version 1.0 with the ultimate objective of generating a second tidy dataset containing averages of each variable for each activity and each subject. 

See the README.md file for background information on the dataset used for this analysis.

##Data

“tidy_data.txt”, a text file containing averages of each variable for each activity and each subject with space-separated values
The first row contains the variable names and all rows below contain the values of those variables.

Structure: Each row contains 79 averaged signal measurements for a given subject performing a given activity.  There are 30 subjects and 6 activities.

##Variables

Subject: subject identifier ranges from 1-30

Activity: Possible values include “LAYING”, “SITTING”, “STANDING”, “WALKING”, “WALKING_DOWNSTAIRS”, and “WALKING_UPSTAIRS”

Units: Before normalization, acceleration variables (labeled with “Accelerometer” prefix) were measured in “g”, while gyroscope variables (labeled with “Gyroscope” prefix) were measured in radians per second.
	All measurements are normalized and bounded within [-1,1].

Domains: Measurements are either part of Time or Frequency domains.
	Time-domain measurements result from the accelerometer and gyroscope raw signals
	Frequency-domain measurements results from applying a Fast Fourier Transform to some of the time-domain measurements.
	Signals from either the time domain (labeled “Time”) or frequency domain (labeled “Frequency”) were measured in X, Y, and Z directions and magnitudes were calculated using the Euclidean norm.

##Transformations Made to Raw Data

The raw data was obtained from: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The script “run_analysis.R” accomplishes the following objectives:

	1.	Merges the training and the test sets to create one data set.
	2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
	3.	Uses descriptive activity names to name the activities in the data set
	4.	Appropriately labels the data set with descriptive variable names. 
	5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for        each activity and each subject.

The script is broken into the following steps to accomplish the objectives above:

#Step 1: download and unzip file
#Step 2: read each file into a data table
#Step 3: merge the datasets
#Step 4: Select mean and standard deviation columns
#Step 5: rename the columns to fit tidy data principles
#Step 6: change column names to be more descriptive
#Step 7: Find averages for each activity and subject
#Step 8: Write the new dataset to a text file