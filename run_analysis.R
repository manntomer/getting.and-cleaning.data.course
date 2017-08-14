library(data.table);library(dplyr);library(tidyr)
setwd("/Users/tomer/Documents/R/coursera R/")
project.url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(project.url,"my.project.zip",mode="wb")
unzip("my.project.zip")


# get activity labels and features
activitylabs <- read.table("UCI HAR Dataset/activity_labels.txt")
activitylabs[,2] <- as.character(activitylabs[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
relevant.features <- grep(".*mean.*|.*std.*", features[,2])
relevant.features.names <- features[relevant.features,2]
relevant.features.names = gsub('-mean', 'Mean', relevant.features.names)
relevant.features.names = gsub('-std', 'Std', relevant.features.names)
relevant.features.names <- gsub('[-()]', '', relevant.features.names)


# get datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[relevant.features]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[relevant.features]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# merge datasets and label them
combined.table <- rbind(train, test)
colnames(combined.table) <- c("subject", "activity", relevant.features.names)

# turn activities & subjects into factors
combined.table$activity <- factor(combined.table$activity, levels = activitylabs[,1], labels = activitylabs[,2])
combined.table$subject <- as.factor(combined.table$subject)
#*************
combined.table<-tbl_df(combined.table)
t.comb<-gather(data = combined.table,variable,value ,-(subject:activity))
t.comb<-dcast(t.comb,subject+activity~variable,mean)
t.comb<-tbl_df(t.comb)
write.table(t.comb, "tidy.data",row.names = FALSE)