# JH-Data-Cleansing-Project
This project analysis is based on data and feature definitions at 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and provided by:
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The Run_analysis.R script transforms data from eight txt files (activity_labels.txt, features.txt,
X_test.txt,y_test.txt,subject_test.txt, X_train.txt,y_train.txt,subject_train.txt) into 
two independent tidy data sets (Step4Dataset and Step5TidyDataset).

Step4Dataset is the tidy data set created by merging the information from the 8 text files, 
identifying each row observation by its subjectID and Activity description in the first two columns, 
including data for 79 mean and standard deviation measurement variables from the original dataset, and 
labeling each of the columns associated with the 79 variables as identified in the ProjectCodebook.txt.
It is a "fat file" that results in 10,299 observations and 81 columns: 
  two identifier columns and 79 measurement variable columns.

Step5TidyDataset is the tidy data set created from the Step4Dataset that calculates the average of each variable measurement
for each subject and each activity, thereby creating a compact data set with 180 observations (one for each subject-activity combination)
for the 79 mean and standard deviation measurement variables as identified in the ProjectCodebook.txt from the original dataset.

The following assumptions were made for this script:
1. The identified eight txt files have been unzipped and downloaded using the file directory structure provided by Smartlab.  
   The top level of this file directory structure is the user's current working directory.
2. The user has installed the dplyr package in his/her system.
3. There is no need to create a variable that identifies which observations were initially in the test -vs- training data sets.
4. The angle measurement variables should not be included in either of the output tidy data sets as they do not generate a mean calculation,
   but rather use a mean variable as input for its calculation.  Thus there are just 79 variables in the original dataset as identified
   in the projectcodebook that calculate a mean or standard deviation estimate for a feature.
   
 The Run_analysis.R script has comments which document the detailed steps used to transform the original data into the two tidy data sets
 described.
