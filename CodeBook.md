#Disclaimer
I submitted this after the deadline, you can consider this an invalid entry,
I'm adding this just for completness.

#The data sets 
The data provided un `https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip`
is divided in 2 sets: train and test.

Both train and test have the same amount of variables and same type of
activities.

train is a set genearated by user that carried a cellphone with them making
measurements of the movements. And test is a set that was generated based on
the observations in train.

The `run_analysis.R` file process both files. The process includes, reading the
observations `X_{train,test}.txt`, appending the activities `y_{train,test}.txt`
and appending the subjects `subjects_{train,test}.txt`

The variables that are relevant for this exercise are the ones that correspond
to the mean and std deviation of the variables value, from an original of +500
columns this got reduced to a total of 68 variables.

The activities are labeled based on the labels provided in the
`activity_labels.txt` file. The column 1 in that file corresponds to an id that
matched the ids under `y_{train,test}.txt` file.

The `run_analysis.R` outputs the content of the cleaned up data set in a file
without any column names. The file name is `clean/data.csv`.

However, during the process the name variables are read from the `features.txt`
file so, after sourcing this file, the user will end up with a data set called
`full` with column names.

#Variables in `clean/data.csv`
The variables 
 - tBodyGyro: mean/std deviation of X, Y, Z axis (float)
 - tBodyGyroJerk: mean/std deviation of X, Y, Z axis (float)
 - tBodyAccMag: mean/std deviation of X, Y, Z axis (float)
 - tGravityAccMag: mean/std deviation of X, Y, Z axis (float)
 - tBodyAccJerkMag: mean/std deviation of X, Y, Z axis (float)
 - tBodyGyroMag: mean/std deviation of X, Y, Z axis (float)
 - tBodyGyroJerkMag: mean/std deviation of X, Y, Z axis (float)
 - fBodyAcc: mean/std deviation (float)
 - fBodyAccJerk: mean/std deviation of X, Y, Z axis (float)
 - fBodyGyr: mean/std deviation of X, Y, Z axis (float)
 - fBodyAccMag: mean/std deviation (float)
 - fBodyBodyAccJerkMag: mean/std deviation (float)
 - fBodyBodyGyroMag: mean/std deviation (float)
 - fBodyBodyGyroJerkMag: mean/std deviation (float)
 - activity: The activity name (based on `activity_labels.txt`) (factor)
 - subject: The subject that perform this measurement (int)

#The subset_analysis.R script
The script `subset_analysis.R` generated a summary of the mean values of every
variable in the full data set grouped by the activity and the subject.

This scripts depends on the cleaned data of the previous script.

The output variables are the same as the `clean/data.csv` but the variables
from 1:66 represent the media of the the fields describe above. This means that
the means belong to all the variables except for activity and subject.
