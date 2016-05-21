===================================================================
##README of the project ending the getting and cleaning data course
===================================================================
The first part of the program checks whether or not the working directory exists. If not, we create it via
dir.create, then we store into the variable url1 the url adress where we can download the file.
We then download the file via download.file; and finally, as the downloaded file is a zip file, we unzip it
via the unzip command in the working directory (specified by exdir).
Then we set the working directory with setwd to the one which contains our datas downloaded.

The second part of the code consists of loading the files into R, to create one tidy dataset (first point of the assignment), which is the merging of the training dataset and the test dataset.
We load the files into R variables using the read.table command, as each file is in txt format.
We add some columns (variables) to the training and test sets provided by Samsung: a column with the numbers which identify the volunteer (from 1 to 30) and a column with the numbers which identifies the type of activity performed (from 1 to 6).
The activities are :
* 1 : Walking
* 2 : Walking upstairs
* 3 : Walking downstairs
* 4 : Sitting
* 5 : Standing
* 6 : Laying
Once our training set and test set are created, we merge them by rows using rbind to create the first tidy dataset (mergedData) required for the assignment.

The third part of the code deals with creating a reduced dataset containing only the measurements on the mean and standard deviation for each measurement.
For this we make use of grep to look for the patterns mean() and std() inside the names of the variables of the dataset. These two commands returns 2 vectors of positions where we can find the matches. We merge these 2 vectors into one (varsofinterests) and we subset our previous dataset mergedData with it and the first 2 columns (volunteer identifier and activity identifier) of this same dataset.
We store this reduced dataset into the variable mergedData2.

The fourth part of the code has the aim to rename every single type of signal by something more understandable by the user. For instance all the signals tBodyAcc are renamed body_acceleration. The rest of the name of the signals are unchanged. This means that, for instance, for this same signal : body_acceleration_mean()-X replaces tBodyAcc_mean()-X.

The last part of the code, fifth part, is aimed to produce a second tidy dataset with the average of each variable for each activity and each subject.
For this we make use of split on our reduced dataframe to create a list based on 2 levels : the activity identifier and the volunteer(subject) identifier.
Then, using sapply we make the mean of each columns of the dataset containing the 10299 measurements for each of the 561 signals. 
Once this is done, we transpose the matrix to get as rows the identifiers (volunteer and experiment in the format volunteer.experiment) and the variables as columns.
Then, we convert the result into a dataframe using as.data.frame since our result is a matrix.
Finally, we export the final tidy dataset in a txt file, using the write.table command, specifying row.names = F and col.names = T, so that we disallow the names of rows which are totally unsignificant.
Eventually, we read once again the dataset written, taking care to specify header=T, meaning that R knows that the first row just indicates the names of the variables.