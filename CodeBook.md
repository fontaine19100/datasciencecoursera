===================================================================
##Codebook of the project ending the getting and cleaning data course
===================================================================
url1 : url where the zip file containing the project is situated

features : variable containing the file features.txt, which is the list of signals (e.g tBodyAcc-mean()-X)

X_test : variable containing the 2947 measurements of each of the 561 signals provided by Samsung for the test sample.

y_test : type of experiment realised by the volunteer in the test dataset:
* 1 : Walking
* 2 : Walking upstairs
* 3 : Walking downstairs
* 4 : Sitting
* 5 : Standing
* 6 : Laying

X_train : variable containing the 7352 measurements of each of the 561 physical variables provided by Samsung for the training sample.

y_train : type of activity realised by the volunteer in the training dataset

subject_train : list of volunteers identified by a number ranging from 1 to 30 (30 volunteers) in the training dataset provided by Samsung

subject_test : list of volunteers identified by a number ranging from 1 to 30 (30 volunteers) in the test dataset provided by Samsung

type_of_experiment : variable which names the list of experiments (activities) performed by the volunteers
for both the test and the training datasets.

volunteer_identifier : variable which names the list of volunteers for both the test and training datasets

test_set : dataset which is the merging by column (using cbind) of the list of volunteers, list of activities performed by them and the measurements of each physical variable for the test sample

training_set : dataset which is the merging by column (using cbind) of the list of volunteers, list of activities performed by them and the measurements of each physical variable for the training sample.

mergedData : dataset which merges by rows (using rbind) the test_set and training_set. We get at the end of the day a dataset with 563 columns (1 for the list of volunteers, 1 for the list of activities realized by the volunteers, 561 for the physical variables) and 10299 rows (sum of 7352 and 2947).

lookformean : vector of positions of columns where we can find the mean signals for each of the physical variable (if there is)
lookforstd : vector of positions of columns where we can find the std signals for each of the physical variable (if there is)

varsofinterests : vector of all the posisitions of the columns where we can find either an std signal or a mean signal. Note that we didn't consider fBodyBodyGyroJerkMag-meanFreq() as a wanted signal.

mergedData2 : subset of mergedData. We subsetted mergedData using the 2 first columns and varsofinterests.

names(mergedData2) : rename of each of the variable in the mergedData2 dataset :
* all tBodyAcc signals are replaced by body_acceleration signals
* all tGravityAcc signals are replaced by gravity_acceleration signals
* all tBodyAccJerk signals are replaced by body_acceleration_Jerk signals
* all tBodyGyro signals are replaced by angular_velocity signals
* all tBodyGyroJerk signals are replaced by angular_velocity_Jerk signals
* all tBodyAccMag signals are replaced by body_acceleration_magnitude signals
* all tGravityAccMag signals are replaced by gravity_acceleration_magnitude signals
* all tBodyAccJerkMag signals are replaced by body_acceleration_Jerk_magnitude signals
* all tBodyGyromag signals are replaced by angular_velocity_magnitude signals
* all tBodyGyroJerkmag signals are replaced by angular_velocity_Jerk_magnitude signals
* all fBodyAcc signals are replaced by body_acceleration_postFFT signals
* all fBodyAcc signals are replaced by gravity_acceleration_postFFT signals
* all fBodyAcc signals are replaced by body_acceleration_Jerk_postFFT signals
* all fBodyAcc signals are replaced by angular_velocity_postFFT signals
* all fBodyAcc signals are replaced by angular_velocity_Jerk_postFFT signals
* all fBodyAcc signals are replaced by body_acceleration_magnitude_postFFT signals
* all fBodyAcc signals are replaced by gravity_acceleration_magnitude_postFFT signals
* all fBodyAcc signals are replaced by body_acceleration_Jerk_magnitude_postFFT signals
* all fBodyAcc signals are replaced by angular_velocity_magnitude_postFFT signals
* all fBodyAcc signals are replaced by angular_velocity_Jerk_magnitude_postFFT signals

mylist : list created by splitting the dataset mergedData2 with respect to 2 levels (volunteer_identifier and type_of_experiment)
average_activities : matrix containing the average of the measurements of the mean and std for each activity and volunteer as columns and an indicator of volunteer identifier and type of experiment realized (e.g 1.2 means first volunteer and second experiment) as rows.
average_dataset : dataset containing each volunteer number (1 to 30), each type of activity he realized, and the mean and std of every signal.
finaldataset: it is not required, but it is just the finaldataset, once written into the file that we reload to R. We take care (very important) to specify header=T as argument as it will indicate to R that the fist line is just the names of the variables.