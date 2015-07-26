Introduction

The script run_analysis.R performs the 5 steps described in the course project's definition.

1) Merges the training and the test sets to create one data set. This is done using cbind() function, in line 43.
2) Extracts only the measurements on the mean and standard deviation for each measurement. This is done using grep() function, in line 46.
3) Uses descriptive activity names to name the activities in the data set. This is done using merge() function, in line 62.
4) Appropriately labels the data set with descriptive variable names. This is done using colnames() function, in line 58.
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. This is done using aggregate(), in line 67.


Variables

- ActLables contains the corresponding activities with their ID from the downloaded files.
- FeaLables contains the correct names for the x_data dataset, which are narrowed down to the list of columns that are required in the project; mean and std.
- x_train, y_train, subject_train, x_test, y_test and subject_test contain the data from the downloaded files.
- x_data, y_data and subject_data are the merge data of their respective train and test data.
- overalldata contains the merge data of x_data, y_data and subject_data.
- finaldata contains a subset from the overall data, which includes the mean and std column.
- tidydata contains the relevant averages which will be later stored in a .txt file.
