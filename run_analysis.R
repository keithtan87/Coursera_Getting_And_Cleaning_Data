##
# The five essential tasks to complete the Course Project are as follows.
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
#    each variable for each activity and each subject.
#
#--------------------------------------------------------------------------------------------

##1. Merges the training and the test sets to create one data set

X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
# merge the two raw data tables together, row-wise.
X <- rbind(X_train, X_test)

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
# merge the two label sets; the labels correspond to activities; these are coded, as integers
Y <- rbind(y_train, y_test)

s_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
s_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
# merge the two subject codes lists
S <- rbind(s_train, s_test)

##2.Extracts only the measurements on the mean and standard deviation for each measurement.

# Read in the feature names from the features.txt file.
features <- read.table("UCI HAR Dataset/features.txt")

# identify all the features that are either standard deviations or means of measurements.
meanstddevfeatures <- grep("(-std\\(\\)|-mean\\(\\))",features$V2)

X2 <- X[, meanstddevfeatures]
names(X2) <- features[meanstddevfeatures, 2]
names(X2) <- gsub("\\(|\\)", "", names(X2))
names(X2) <- tolower(names(X2))

## 3. Uses descriptive activity names to name the activities in the data set.
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

## 4. Appropriately labels the data set with descriptive activity names.
names(S) <- "subject"
final <- cbind(S, Y, X2)
write.table(final, "final_data.txt", row.names = FALSE)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
#    each variable for each activity and each subject.
temp <- final[, 3:dim(final)[2]]
average_final <- aggregate(temp,list(final$subject, final$activity), mean)
names(average_final)[1] <- "Subject"
names(average_final)[2] <- "Activity"

write.table(average_final, "average_final_data.txt",row.names = FALSE)
