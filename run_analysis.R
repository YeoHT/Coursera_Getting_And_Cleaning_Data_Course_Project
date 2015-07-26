#You should create one R script called run_analysis.R that does the following. 

#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(plyr)

# create "features" data set
FeaLables <- read.table("UCI HAR Dataset/features.txt")
FeaLables[,2] = gsub('-mean', 'Mean', FeaLables[,2])
FeaLables[,2] = gsub('-std', 'Std', FeaLables[,2])
FeaLables[,2] = gsub('[-()]', '', FeaLables[,2])

# create "activity" data set
ActLables <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(ActLables) <- c("ActivityID", "Activity")

# load x, y & subject train and test data set

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# create 'x' data set
x_data <- rbind(x_train, x_test)

# create 'y' data set, aka actitivy
y_data <- rbind(y_train, y_test)

# create 'subject' data set
subject_data <- rbind(subject_train, subject_test)
colnames(subject_data) <- "SubjectID"

# create overall data set, x_data must come first because so that the ColToExtract can work
overalldata <- cbind(x_data,y_data,subject_data)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
ColToExtract <- grep(".*Mean.*|.*Std.*", FeaLables[,2])

# First reduce the features table to what we want
FeaLables <- FeaLables[ColToExtract,]

# add the subject and activity column into the column
ColToExtract <- c(ColToExtract, 562, 563)

# remove the unwanted columns from overalldata
finaldata <- overalldata[,ColToExtract]

# add column names (features) to finaldata
colnames(finaldata) <- c(FeaLables$V2, "ActivityID", "Subject")
colnames(finaldata) <- tolower(colnames(finaldata))

# add activity label into finaldata
finaldata <- merge(ActLables,finaldata, by.x = "ActivityID", by.y = "activityid", all.y = TRUE, sort = FALSE)

# calculate the average of each variable for each activity and each subject
finaldata$Activity <- as.factor(finaldata$Activity)
finaldata$subject <- as.factor(finaldata$subject)
tidydata = aggregate(finaldata, by=list(activity = finaldata$Activity, subject=finaldata$subject), mean)
tidydata <- tidydata[-c(4,91)]

#export the tidydata set as tidy.txt
write.table(tidydata, "tidy.txt", sep = ",", row.names = FALSE)
