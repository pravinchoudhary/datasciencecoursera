## Data Science - "Getting and Cleaning Data" - Course Project
This document describes the code inside `run_analysis.R`. Purpose or objective of the 'R' script is to read the data as provided and then creating a single tidy data set out of multiple input data sets containg subject, feature variables and label.

### Load zip files and extract them. input file paths are used as  relative path Vs. absolute path

### Reading and creting one dataset per subject, training and label variables

Merge following datset (row wise)

* `UCI HAR Dataset/train/X_train.txt` and `UCI HAR Dataset/test/X_test.txt`
* `UCI HAR Dataset/train/y_train.txt` and `UCI HAR Dataset/teset/y_test.txt`
* `UCI HAR Dataset/train/subject_train.txt` and `UCI HAR Dataset/test/subject_test.txt`


## Label data variables accordingly 
   * subject
   * Feature names as per 'features.txt' file content
   * activity

## Data filter and cleanup
   * Filter only those columns having "mean" and "std" (standard daviation data variables)
   * Remove unwanted characters from the label

## creating a single dataset
using column bind creat a single dataset set containing
   * subject data
   * feature variables (X)
   * label (y)
at this point of thme we will have 10299 records of data

## final tidy dataset
   * Group the merged single data set by "activity" & subject. 
   * summarize data using mean function for each of the feature variables

we are using "group_by" & "summarise" function of dplyr library. after this step we should have 180 records of cleaned and trasfored data sets.


## Writing final data to a local file
dump data final tidy dataset to a txt  file using table
Creates the output dir if it doesn't exist and writes `meanAndStdAverages` data frame to the ouputfile.