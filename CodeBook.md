CodeBook.md

Christopher Hogan
February 14, 2016
Getting and Cleaning Data - coursera.org

Data for this analysis come from:
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Data are originally from:
	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
	[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Description of data collection (from UCI website cited above):
	The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
	The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

Description of tidy data output:
	Data labels contain mean() [indicates mean value] or std() [indicates standard deviation]
	Data with "XYZ" is provided for all three axes
	All data has been averaged by activity and subject
	All data has been normalized to -1,1 scale

Data labels:
	subject - indicates study participant (1-30)
	activity - indicates activity being completed by subject when reading was taken (LAYING,SITTING,STANDING,WALKING,WALKING_DOWNSTAIRS,WALKING_UPSTAIRS)
	tBodyAcc-XYZ - body acceleration (standard gravity units 'g')
	tGravityAcc-XYZ - gravity acceleration (standard gravity units 'g')
	tBodyAccJerk-XYZ - body jerk (gravity units/second)
	tBodyGyro-XYZ - body angular velocity (rad/sec)
	tBodyGyroJerk-XYZ - body angular velocity jerk (rad/sec^2)
	tBodyAccMag - magnitude of body acceleration vector (standard gravity units 'g')
	tGravityAccMag - magnitude of gravity acceleration vector (standard gravity units 'g')
	tBodyAccJerkMag - magnitude of body jerk vector (gravity units/second)
	tBodyGyroMag - magnitude of body angular velocity vector (rad/sec)
	tBodyGyroJerkMag - magnitude of body angular velocity jerk vector (rad/sec^2)
	fBodyAcc-XYZ - fast Fourier transform of tBodyAcc-XYZ
	fBodyAccJerk-XYZ - fast Fourier transform of tBodyAccJerk-XYZ
	fBodyGyro-XYZ - fast Fourier transform of tBodyGyro-XYZ
	fBodyAccMag - fast Fourier transform of tBodyAccMag
	fBodyAccJerkMag - fast Fourier transform of tBodyAccJerkMag
	fBodyGyroMag - fast Fourier transform of tBodyGyroMag
	fBodyGyroJerkMag - fast Fourier transform of tBodyGyroJerkMag
	
	
Script run_analysis.R takes raw data from source cited above and does the following:
	1) Read in list of data to use as column headers (features.txt)
	2) Read in test (X_test.txt) and training (X_train.txt) data sets
	3) Read in data that identifies subject and activity for test (y_test.txt,subject_test.txt) and training (y_train.txt,subject_train.txt)
	4) Appliy column headings to label data
	5) Isolate headings that identify mean [mean()] and standard deviation [std()]
	6) Select measurements of mean [mean()] and standard deviation [std()] only
	7) Tack on data to identify subject and activity being completed
	8) Combine data for testing and training
	9) Average mean() and std() for each subject and each activity
	10) Output tidy dataset to "traintest_summary.csv"