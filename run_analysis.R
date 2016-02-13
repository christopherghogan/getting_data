#
# Christopher Hogan, Feb. 14 2016
# Getting and Cleaning Data - coursera.org
# Final Project
#
# This file should be run from folder ./UCI HAR Dataset with contents:
#	./test
#	./train
#	activity_labels.txt
#	features.txt
#	features_info.txt
#	README.txt


# read features of data (labels)
features <- read.table("features.txt")

# convert "features" V2 to character to allow grep for mean() and std() labels
library(dplyr)
features <- mutate(features,V2=as.character(V2))

# find labels with mean() or std() and label TRUE in column named "use"
features <- mutate(features,mean=grepl("mean()",features$V2,fixed=TRUE))
features <- mutate(features,std=grepl("std()",features$V2,fixed=TRUE))
features <- mutate(features,use=grepl("TRUE",features$std|features$mean))
features <- select(features,V1,V2,use)

# make V2 into list of column headers
headers <- t(features$V2)

# read in test data and name columns
test <- read.table("./test/X_test.txt")
	colnames(test) <- headers
test_activity <- read.table("./test/y_test.txt") %>%
	rename(activity=V1)
test_subject <- read.table("./test/subject_test.txt") %>%
	rename(subject=V1)
 
# read in train data and name columns
train <- read.table("./train/X_train.txt")
	colnames(train) <- headers
train_activity <- read.table("./train/y_train.txt") %>%
	rename(activity=V1)
train_subject <- read.table("./train/subject_train.txt") %>%
	rename(subject=V1)

# create list of headers for only mean() and std() data
features_true <- filter(features,features$use=="TRUE")
headers_true <- t(features_true$V2)

# select only test and train data for mean() and std()
test_true <- test[,headers_true]
train_true <- train[,headers_true]

# add subject and activity labels to test and train data
test_true <- cbind(test_subject,test_activity,test_true)
train_true <- cbind(train_subject,train_activity,train_true)

# join test and train data
traintest <- rbind(train_true,test_true)

# update activity column to include descriptions
traintest$activity <- sub("1","WALKING",traintest$activity)
traintest$activity <- sub("2","WALKING_UPSTAIRS",traintest$activity)
traintest$activity <- sub("3","WALKING_DOWNSTAIRS",traintest$activity)
traintest$activity <- sub("4","SITTING",traintest$activity)
traintest$activity <- sub("5","STANDING",traintest$activity)
traintest$activity <- sub("6","LAYING",traintest$activity)

# create new data frame grouped by activity and subject
traintest_grouped <- group_by(traintest,subject,activity)

# summarize all variables by activity and subject
traintest_summary <- summarize_each(traintest_grouped,funs(mean))

# write processed dataframes to directory as csv for later use
write.csv(traintest,file="traintest.csv",quote=FALSE,row.names=FALSE)
write.csv(traintest_summary,file="traintest_summary.csv",quote=FALSE,row.names=FALSE)

# remove extra files
rm(list=ls(pattern="^test"))
rm(list=ls(pattern="headers*"))
rm(list=ls(pattern="features*"))
rm(list=ls(pattern="train_"))
rm("train")
rm("traintest_grouped")