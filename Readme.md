# The Script

## The run_analysis.R script does the following:

* Merges training and test datasets into one.
* Extracts only the required mesurements (mean and standard deviation) of specified features.
* Uses descriptive activity names.
* Labels the data with descriptive activity names.
* Creates a second tidy dataset with the average of each variable for each activity and each subject.

## How does it work.

1. Extracts the mean and standard deviation features.
2. Get the list of activities.
3. Get the list of subjects.
4. Join both reduced datasets.
5. Put each variable on its own row.
6. Recast the table, using subject/activity pairs, applying the mean function to each vector of values in each subject/activity pair. This is the tidy dataset.
7. Write the tidy dataset to disk.