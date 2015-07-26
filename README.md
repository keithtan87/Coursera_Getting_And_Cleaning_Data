# Coursera_Getting_And_Cleaning_Data
This is source code for Getting and Cleaning Data Course Project to create a tidy data set of wearable computing data originally from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Document list
* i. README.md -- instruction and guideline
* ii. CodeBook.md -- codebook describing variables, the data and transformations
* iii. run_analysis.R -- Tidy data set source code

## Data Files
Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Unzip the source zipped file into your working directory. The folder name is "UCI HAR Dataset".
* activity_labels.txt
* features.txt
* test folder
* train folder

## run_analysis.R

* Step 1:
  * Read all the test and training files: y\_test.txt, subject\_test.txt and X_test.txt.
  * Combine the files to a data frame in the form of subjects, labels, the rest of the data.

* Step 2:
  * Read the features from features.txt and filter it to only leave features that are either means ("mean()") or standard deviations ("std()"). The reason for leaving out meanFreq() is that the goal for this step is to only include means and standard deviations of measurements, of which meanFreq() is neither.
  * A new data frame is then created that includes subjects, labels and the described features.

* Step 3:
  * Read the activity labels from activity_labels.txt and replace the numbers with the text.

* Step 4:
  * Make a column list (includig "subjects" and "label" at the start)
  * Tidy up the list by removing all non-alphanumeric characters and converting the result to lowercase as well as labels the data set
  * Generate the data frame into file "final_data.txt"
  
* Step 5:
  * Create a new data frame by finding the mean for each combination of subject and label. It's done by `aggregate()` function and the file name is called "average_final_data.txt"
  
* Note: Use data <- read.table("average_final_data.txt") to read the data.
