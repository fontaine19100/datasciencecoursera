# Subject of the assignment:
# 
# You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable
#    for each activity and each subject.
library(dplyr)

#first we create the working directory of the project if non existing and download and unzip the file
if(!file.exists("course_project_gettingandcleaningdatas"))
{
  dir.create("course_project_gettingandcleaningdatas")
  url1<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url1,destfile="./course_project_gettingandcleaningdatas/accelerometers.zip",method="curl")
  unzip("./course_project_gettingandcleaningdatas/accelerometers.zip", exdir = "./course_project_gettingandcleaningdatas")
}
setwd("/home/yoda/Desktop/dataanalysiscourse/thirdunit/course_project_gettingandcleaningdatas/UCI HAR Dataset/")

#we load into R all the files needed to create the test set and training set
features<-read.table("features.txt")[,2]
X_test<-read.table("test/X_test.txt")
X_train<-read.table("train/X_train.txt")
y_test<-read.table("test/y_test.txt")
y_train<-read.table("train/y_train.txt")
subject_train<-read.table("train/subject_train.txt")
subject_test<-read.table("test/subject_test.txt")
names(X_test)=features
names(X_train)=features
names(y_test)="type_of_experiment"
names(y_train)="type_of_experiment"
names(subject_test)="volunteer_identifier"
names(subject_train)="volunteer_identifier"
test_set=cbind(subject_test,y_test,X_test)
training_set=cbind(subject_train,y_train,X_train)

#then, we merge the training and the test sets to create one tidy (one variable per column) dataset
mergedData=rbind(test_set,training_set)

# #we look for mean() and std() into the tidy dataset separately as we want an exact match. 
# #Indeed, at line 552, there is fBodyBodyGyroJerkMag-meanFreq() which we don't want to consider.
lookformean<-grep("mean()",names(mergedData),fixed=TRUE)
lookforstd<-grep("std()",names(mergedData),fixed=TRUE)
varsofinterests<-sort(c(lookformean,lookforstd))
mergedData2<-mergedData[,c(1:2,varsofinterests)]

#renaming of the activities (columns) 
names(mergedData2)<-gsub("tBodyAcc-","body_acceleration_",names(mergedData2))
names(mergedData2)<-gsub("tGravityAcc-","gravity_acceleration_",names(mergedData2))
names(mergedData2)<-gsub("tBodyAccJerk-","body_acceleration_Jerk_",names(mergedData2))
names(mergedData2)<-gsub("tBodyGyro-","angular_velocity_",names(mergedData2))
names(mergedData2)<-gsub("tBodyGyroJerk-","angular_velocity_Jerk",names(mergedData2))
names(mergedData2)<-gsub("tBodyAccMag-","body_acceleration_magnitude_",names(mergedData2))
names(mergedData2)<-gsub("tGravityAccMag-","gravity_acceleration_magnitude_",names(mergedData2))
names(mergedData2)<-gsub("tBodyAccJerkMag-","body_acceleration_Jerk_magnitude_",names(mergedData2))
names(mergedData2)<-gsub("tBodyGyroMag-","angular_velocity_magnitude_",names(mergedData2))
names(mergedData2)<-gsub("tBodyGyroJerkMag-","angular_velocity_Jerk_magnitude_",names(mergedData2))

names(mergedData2)<-gsub("fBodyAcc-","body_acceleration_postFFT_",names(mergedData2))
names(mergedData2)<-gsub("fGravityAcc-","gravity_acceleration_postFFT_",names(mergedData2))
names(mergedData2)<-gsub("fBodyAccJerk-","body_acceleration_Jerk_postFFT_",names(mergedData2))
names(mergedData2)<-gsub("fBodyGyro-","angular_velocity_postFFT_",names(mergedData2))
names(mergedData2)<-gsub("fBodyGyroJerk-","angular_velocity_Jerk_postFFT_",names(mergedData2))
names(mergedData2)<-gsub("fBodyAccMag-","body_acceleration_magnitude_postFFT_",names(mergedData2))
names(mergedData2)<-gsub("fGravityAccMag-","gravity_acceleration_magnitude_postFFT_",names(mergedData2))
names(mergedData2)<-gsub("fBodyBodyAccJerkMag-","body_acceleration_Jerk_magnitude_postFFT_",names(mergedData2))
names(mergedData2)<-gsub("fBodyBodyGyroMag-","angular_velocity_magnitude_postFFT_",names(mergedData2))
names(mergedData2)<-gsub("fBodyBodyGyroJerkMag-","angular_velocity_Jerk_magnitude_postFFT_",names(mergedData2))

#we split the dataframe into a list with 2 levels : the volunteer indentifier(1 to 30) and the type of
#experiment (1 to 6)
mylist<-split(mergedData2,list(mergedData2$volunteer_identifier,mergedData2$type_of_experiment))
#then we calculate the mean of each activities using sapply and a anomymous function, we transpose the result
#to get as columns of the resulting matrix the names of the physical variables
average_activities<-t(sapply(mylist,function(x) colMeans(x)))
#finally we convert the result into a dataframe
average_dataset<-as.data.frame(average_activities)
setwd("/home/yoda/Desktop/dataanalysiscourse/thirdunit")
#we export the dataset
write.table(average_dataset,file="final_tidy_dataset.txt",row.names = F, col.names = T)
finaldataset<-read.table("final_tidy_dataset.txt",header=T)