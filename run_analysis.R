run_analysis <- function() {
    ## load required libraries
    library(dplyr)
    library(tidyr)
    
    ## download the input data file
    ## download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./projectDataset.zip")
    
    ## Read train and test subject/X/y data files
    read.table("./UCI HAR Dataset/train/subject_train.txt")
    subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
    y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
    subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
    y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
    
    
    ## In sthis part we are creating one file each for each "subject", 
    ## "Feature/X"and "Label/y" (Step 1)
    subject_combined <- rbind(subject_train, subject_test)
    X_combined <- rbind(X_train, X_test)
    y_combined <- rbind(y_train, y_test)
    
    names(subject_combined) <- c("subject")
    names(y_combined) <- c("activity")
    
    ## Labeling feature variables in a descriptive manner using information
    ## in "features.txt" (Step 4)
    ## Also cleaning up unwanted charaters (e.g. '(')
    feature <- read.table("./UCI HAR Dataset/features.txt")
    tmp <- as.vector(feature[ , 2])
    tmp <- gsub("[()]", "", tmp)
    names(X_combined) <- tmp
    
    ## Extract only mean and standard deviation features (Step 2)
    X_combined_mean_std <- X_combined[ ,grep("mean|std", names(X_combined))]
    
    ## Use descriptive activity names to name the activities in the data set (Step 3)
    y_combined <- as.data.frame(factor(y_combined[, "activity"], labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")))
    names(y_combined) <- c("activity")
    
    ## combine subject, feature and activit into one (Step 1)
    data_combined <- cbind(subject_combined, X_combined_mean_std, y_combined)
    
    ## Create a independent data set with average of each variable 
    ## for each activity and each subject (Step 5)
    tidy_data <- group_by(data_combined, activity, subject)
    tidy_data <- summarise_each(tidy_data, funs(mean))
    
    ## Dump the tidy data set to a file
    write.table(tidy_data, "./sample_tidy_data.txt", row.names = FALSE)
}