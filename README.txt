README.txt

Christopher Hogan, Feb. 14 2016
Getting and Cleaning Data - coursera.org
Final Project

Use run_analysis.R from folder with contents:
	./test
	./test/X_test.txt
	./test/y_test.txt
	./test/subject_test.txt
	./train
	./train/X_train.txt
	./train/y_train.txt
	./train/subject_train.txt
	features.txt
	
run_analysis.R will do the following:
	1) Read in list of data to use as column headers (features.txt)
	2) Read in test (X_test.txt) and training (X_train.txt) data sets
	3) Read in data that identifies subject and activity for test (y_test.txt,subject_test.txt) and training (y_train.txt,subject_train.txt)
	4) Apply column headings to label data
	5) Isolate headings that identify mean [mean()] and standard deviation [std()]
	6) Select measurements of mean [mean()] and standard deviation [std()] only
	7) Tack on data to identify subject and activity being completed
	8) Combine data for testing and training
	9) Average mean() and std() for each subject and each activity
	10) Output tidy dataset to "traintest_summary.csv"
	