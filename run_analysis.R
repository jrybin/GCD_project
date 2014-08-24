# Defining working directory.
setwd("~/Documents/!JAKUB/97_Coursera/Data_Specialization/3_Getting_And_Cleaning_Data/Assignment")

# First, load the required library.
library(reshape2)

# Then predefine output file, make a vector of extracted features and its' names as well as activities and its' names.
tidy.data<-"tidy.txt"
extracted.f<-c(1, 2, 3, 4, 5, 6, 41, 42, 43, 44, 45, 46, 81, 82, 83, 84, 85, 86, 121, 122, 123, 124, 125, 126, 161, 162, 163, 164, 165, 166, 201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 266, 267, 268, 269, 270, 271, 345, 346, 347, 348, 349, 350, 424, 425, 426, 427, 428, 429, 503, 504, 516, 517, 529, 530, 542, 543)
extracted.f.n<-c("tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z", "tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z", "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y", "tGravityAcc-mean()-Z", "tGravityAcc-std()-X", "tGravityAcc-std()-Y", "tGravityAcc-std()-Z", "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z", "tBodyAccJerk-std()-X", "tBodyAccJerk-std()-Y", "tBodyAccJerk-std()-Z", "tBodyGyro-mean()-X", "tBodyGyro-mean()-Y", "tBodyGyro-mean()-Z", "tBodyGyro-std()-X", "tBodyGyro-std()-Y", "tBodyGyro-std()-Z", "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z", "tBodyGyroJerk-std()-X", "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z", "tBodyAccMag-mean()", "tBodyAccMag-std()", "tGravityAccMag-mean()", "tGravityAccMag-std()", "tBodyAccJerkMag-mean()", "tBodyAccJerkMag-std()", "tBodyGyroMag-mean()", "tBodyGyroMag-std()", "tBodyGyroJerkMag-mean()", "tBodyGyroJerkMag-std()", "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z", "fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z", "fBodyAccJerk-mean()-X", "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z", "fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y", "fBodyAccJerk-std()-Z", "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z", "fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z", "fBodyAccMag-mean()", "fBodyAccMag-std()", "fBodyBodyAccJerkMag-mean()", "fBodyBodyAccJerkMag-std()", "fBodyBodyGyroMag-mean()", "fBodyBodyGyroMag-std()", "fBodyBodyGyroJerkMag-mean()", "fBodyBodyGyroJerkMag-std()")
activities<-c(1, 2, 3, 4, 5, 6)
activity.n<-c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

# Function that creates a feature file.
features.f <- function(name) {
  paste("X_", name, ".txt", sep = "")
}

# Function that creates activities file.
activities.f <- function(name) {
  paste("Y_", name, ".txt", sep = "")
}

# Function that creates subjects file.
subjects.f <- function(name) {
  paste("subject_", name, ".txt", sep = "")
}

# This funtcion gets data for a single data set.
get.data<-function(dir, name) {
  real.dir<-file.path(dir, name)
  features.n<-file.path(real.dir, features.f(name))
  activities.n<-file.path(real.dir, activities.f(name))
  subjects.n<-file.path(real.dir, subjects.f(name))
  
  # Then reads the features table.
  features.t<-read.table(features.n)[extracted.f]
  names(features.t) <- extracted.f.n  
  tidy.data <- features.t
  
  # Then reads the activities list.
  activities.t <- read.table(activities.n)
  names(activities.t) <- c("activity")
  activities.t$activity <- factor(activities.t$activity, levels = activities, labels = activity.n)
  tidy.data <- cbind(tidy.data, activity = activities.t$activity)
  
  # Then reads the subjects list.
  subjects.t <- read.table(subjects.n)
  names(subjects.t) <- c("subject")
  tidy.data <- cbind(tidy.data, subject = subjects.t$subject)
  
  # And in the end returnd the tidy dataset.
  tidy.data
}

# Final function, that performs all required tasks and writes 
# a tidy dataset to harddrive (into the UCI HAR Dataset folder)

run.analysis <- function(dir) {
  
  
  # Data read.
  test <- get.data(dir, "test")
  train <- get.data(dir, "train")
  
  # Join.
  full <- rbind(test, train)
  
  # Reshape.
  full.long <- melt(full, id = c("subject", "activity"))
  full.wide <- dcast(full.long, subject + activity ~ variable, mean)
  
  # Rename the tidy data.
  full.tidy <- full.wide
  
  # Save the tidy dataset.
  tidy.file.name <- file.path(dir, tidy.data)
  write.table(full.tidy, tidy.file.name, row.names = FALSE, quote = FALSE)
}

# In order to check the code, after getting all functions to the environment 
# run the function on the folder where data are stored. 
# Enter your directory properly in order to get the output.
# Script file needs to be in the same folder as UCI HAR Dataset.

setwd("~/Documents/!JAKUB/97_Coursera/Data_Specialization/3_Getting_And_Cleaning_Data/Assignment/UCI HAR Dataset")

run.analysis("~/Documents/!JAKUB/97_Coursera/Data_Specialization/3_Getting_And_Cleaning_Data/Assignment/UCI HAR Dataset")

