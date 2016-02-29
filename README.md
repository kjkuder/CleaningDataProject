# CleaningDataProject

This repository includes:
* tidy.csv - a tidy data set of raw observations, described below
* tidy2.csv - a tidy data set of averages for each individual and activity, described below
* run_analysis.R - the script used to generate the two data sets
* codebook.md - a codebook describing the data in the two data sets
* README.md - this file


## tidy.csv
The first file *tidy.csv* includes cleaned data from the UCI Machine Learning Repository described at 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

and provided by course instructors for this project at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The following steps were performed on the raw data by the script *run_analysis.R*:
 1. The training and test data files (*X_train.txt* and *X_test.txt*) were read and combined into a single data set.
 2. The list of features (types of measurements) were read from features.txt. A logical matrix identified the data points for mean and standard deviation by matching "mean()" and "std()". The variable "meanFreq()" was not included.
 3. The logical matrix with the desired variables was used to subset the data set that was combined in step 1.
 4. Variable names were cleaned up to be more readable and applied.
 5. Activities and participants (subjects) were merged from the training and test data files the same way as data observations were in step 1. Activity numbers were changed to friendly activity names using actvity_labels.txt from the source material. Both activity and subjects were added to the data set as new columns and given descriptive column names.
 6. The file was written to tidy.csv
 


## tidy2.csv

The second file tidy2.csv shows the average of each data observation, grouped by subject and activity

The following steps were performed as part of the script *run_analysis.R*:
 1. The file tidy.csv was read
 2. The data was grouped by subject and activity
 3. An average value for every data column not part of the grouping was created
 4. The column names were updated to include "Avg" at the beginning
 5. The file was written to tidy2.csv
