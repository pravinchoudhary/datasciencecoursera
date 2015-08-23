## download the input data file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./projectDataset.zip")

## Read train and test subject/X/y data files
read.table("./UCI HAR Datasettrain/subject_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")


## Step 1: merge and create one data file
subject_combined <- rbind(subject_train, subject_test)
names(subject_combined) <- c("subject")

X_combined <- rbind(X_train, X_test)
y_combined <- rbind(y_train, y_test)
names(y_combined) <- c("activity")


## Step 2: Following code will fine all mean and std columns / features but somehow
##         its not working while summarizing

##read.table("./features.txt")
##feature <- read.table("./features.txt")
##X_combined <- X_combined[sort(c(grep("std", colnames(X_combined)), grep("mean", colnames(X_combined)))), ]
##         taking first 6 sample of mean and std columns
sample_X_combined <- X_combined[, 1:6]

## Step 3: Putting descriptive activity names to name the activities in the data set
factor(y_combined[, "activity"], labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

## combine subject, feature and activit into one
data_combined <- cbind(subject_combined, sample_X_combined, y_combined)

## Step 4: set labels the data set with descriptive variable names
## Step 5: data set with the average of each variable for each activity and each subject
tidy_data <- group_by(data_combined, activity)
tidy_data <- summarise(output, tBodyAccXMean = mean(V1, na.rm = TRUE),
                       tBodyAccYMean = mean(V2, na.rm = TRUE),
                       tBodyAccZMean = mean(V3, na.rm = TRUE),
                       tBodyAccXStd = mean(V4, na.rm = TRUE),
                       tBodyAccYStd = mean(V5, na.rm = TRUE),
                       tBodyAccZStd = mean(V5, na.rm = TRUE))

write.table(tidy_data, "./sample_tidy_data.txt")
