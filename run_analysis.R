#using package dplyr for this assignment

install.packages(c("plyr","dplyr"))
library(dplyr)


#reading all files from zip folder into R

features<-read.table("features.txt", header = FALSE)
activity_labels<-read.table("activity_labels.txt")

train_labels<-read.table("train/y_train.txt", header = FALSE)
train_subject<-read.table("train/subject_train.txt", header = FALSE)
train_data<-read.table("train/X_train.txt", header = FALSE)

test_labels<-read.table("test/y_test.txt", header = FALSE)
test_subject<-read.table("test/subject_test.txt", header = FALSE)
test_data<-read.table("test/X_test.txt", header = FALSE)


#Assigning names for each column in both train and test data

colnames(train_data)<-t(features[2])
colnames(train_labels)<-c("Activity_Labels")
colnames(train_subject)<-c("Subject")

colnames(test_data)<-t(features[2])
colnames(test_labels)<-c("Activity_Labels")
colnames(test_subject)<-c("Subject")


#Adding columns with labels and subject numbers to the data with observations for both train and test datasets

train_data<-cbind(train_labels,train_data)
train_data<-cbind(train_subject,train_data)

test_data<-cbind(test_labels,test_data)
test_data<-cbind(test_subject,test_data)


#Combining train and test datasets into one

comb_data<-rbind(train_data,test_data)


#Looking for columns with mean and standard deviation values for each feature

mean_position<-grep("mean\\()", names(comb_data))
std_position<-grep("std\\()", names(comb_data))


#Selecting columns with mean and standard deviation values

comb_data_mean_std<-comb_data[,c(1,2,mean_position, std_position)]


#Starting to build clean dataset

tidy_data<-comb_data_mean_std


#Changing names in Subject column (example: "1" -> "Subject 1")

for (i in 1:nrow(tidy_data)){
  
  for (k in 1:30){
    tidy_data$Subject[tidy_data$Subject==k]<-paste("Subject ",as.character(k))
  }

  i<-i+1
}


#Changing names in Activity_Labels column (example: "1" -> "WALKING")

for (i in 1:nrow(tidy_data)){
  for (j in 1:6){
    tidy_data$Activity_Labels[tidy_data$Activity_Labels == j]<-paste(activity_labels[j,2])
  }
  i<-i+1
}


#Changing names in features columns (example: "tBodyAcc-mean()-X" -> "TimeBodyAccelerometer-Mean-X")

names(tidy_data)<-gsub("^t", "Time", names(tidy_data))
names(tidy_data)<-gsub("^f", "Frequency", names(tidy_data))
names(tidy_data)<-gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data)<-gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data)<-gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data)<-gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data)<-gsub("mean\\()", "Mean", names(tidy_data))
names(tidy_data)<-gsub("std\\()", "STD", names(tidy_data))


#Grouping data by Subject and Activity_Labels columns, calculating mean value for each feature column

Subject<-tidy_data$Subject
Activity_Labels<-tidy_data$Activity_Label
tidy_data_summary<-aggregate(. ~Subject + Activity_Labels, tidy_data, mean)



write.table(file="Tidy data.txt",tidy_data_summary,row.name=FALSE)


