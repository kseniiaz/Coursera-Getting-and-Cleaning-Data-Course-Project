# Coursera-Getting-and-Cleaning-Data-Course-Project
The code consists of several steps of implementation:
1. Reading all files from provided zip folder (features.txt, activity_labels.txt, y_train.txt, subject_train.txt, X_train.txt, y_test.txt, 
subject_test.txt and X_test.txt)
2. Adding names for each column in train data set by using function colnames() in accordance with second column in features.txt; applying cbind() 
function to insert data from y_train.txt and subject_train.txt as 1st and 2nd columns to the train data set
3. Same procedure for test data set
4. Merging train and test data sets into one file by using rbind() function
5. Calling grep() function to search for all columns with mean and std values for each feature, and limiting data to only those columns (while
keeping Subject and Activity Labels columns as well)
6. Changing names to create tidy data set:
* For each value in Subject column performing following change: "1" -> "Subject 1"
* For each value in Activity Labels column looking for corresponding label in activity_labels.txt (example: "1" -> "WALKING")
* Doing data cleaning for each column with mean and std values for observed features (example: "tBodyAcc-mean()-X" -> "TimeBodyAccelerometer-Mean-X")
7. Using aggregate() function to group data by Subject & Activity Label and calculate average value for each feature column
8. Writing output into a file
