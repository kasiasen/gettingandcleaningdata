#1 . Merge the training and the test sets to create one data set.

#files in working directory
list.files("/home/kasia/Dokumenty/coursea/get_clean_data/UCI HAR Dataset")

#read files into R

#list of features
features <- read.table("/home/kasia/Dokumenty/coursea/get_clean_data/UCI HAR Dataset/features.txt")
colnames(features) <- c("feature.id", "variable_name" )

#list of activities
activity_labels <- read.table("/home/kasia/Dokumenty/coursea/get_clean_data/UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("label.id", "activity_name")

#training set
X_train <- read.table("/home/kasia/Dokumenty/coursea/get_clean_data/UCI HAR Dataset/train/X_train.txt")
X_train_labels <- read.table("/home/kasia/Dokumenty/coursea/get_clean_data/UCI HAR Dataset/train/y_train.txt")

#test set
X_test<- read.table("/home/kasia/Dokumenty/coursea/get_clean_data/UCI HAR Dataset/test/X_test.txt")
X_test_labels <- read.table("/home/kasia/Dokumenty/coursea/get_clean_data/UCI HAR Dataset/test/y_test.txt")

#list of subjects for train/test set
subject_train <- read.table("/home/kasia/Dokumenty/coursea/get_clean_data/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("/home/kasia/Dokumenty/coursea/get_clean_data/UCI HAR Dataset/test/subject_test.txt")

#merge all files for train and test sets
train_full <- cbind ( X_train, subject_train, X_train_labels )
test_full <- cbind ( X_test, subject_test, X_test_labels )

#merge train and test sets together
step1_full_dataset <- rbind( train_full, test_full )
colnames( step1_full_dataset ) <- c( colnames(X_test), "subject.id", "label.id" )

#2. Extract only the measurements on the mean and standard deviation for each measurement.

mean_std_subset <- c( grep( "mean()", features$variable_name, fixed = TRUE ) , grep( "std()", features$variable_name, fixed = TRUE ) )
step2_mean_std_subset <- step1_full_dataset [ , c(mean_std_subset, ncol(step1_full_dataset)-1 , ncol(step1_full_dataset) ) ]

#3. Use descriptive activity names to name the activities in the data set

merged <- merge( step2_mean_std_subset, activity_labels, by.x = "label.id", by.y = "label.id" )
step3_activity_names <- merged[ , c(2:ncol(merged)) ]

#4. Appropriately label the data set with descriptive variable names.

f.id <- paste("V", as.character(features[ mean_std_subset, "feature.id" ]), sep = '' )
f.name <- as.character(features[ mean_std_subset, "variable_name" ])

step4_descr_variable_names <- step3_activity_names

for (i in 1:length(f.id)) {
  if ( colnames( step4_descr_variable_names ) [i] == f.id [i] ) { colnames( step4_descr_variable_names ) [i] <- f.name [i] }
}

colnames(step4_descr_variable_names)

#5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

step5_tidy_dataset <- aggregate( . ~ subject.id + activity_name, step4_descr_variable_names, mean )
write.table(step5_tidy_dataset, file = "/home/kasia/Dokumenty/coursea/get_clean_data/ksenderowska_get_clean_data_project.txt", row.name = FALSE)
