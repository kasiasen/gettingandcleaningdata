==================================================================

==================================================================
# Introduction
The attached script (run_analysis.R) performs merging, cleaning and early pre-processing of data collected with an experiments 
carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone 
(Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular 
velocity were captured at a constant rate of 50Hz.  
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding 
windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components,
was separated using a Butterworth low-pass filter into body acceleration and gravity. From each window, a vector of features was obtained 
by calculating variables from the time and frequency domain.

The script prepares raw data for further analyses is the following steps:

### Step 1
- reads following files from 'UCI HAR Dataset' directory into R: 
* features.txt (plus sets appriopriate column names)
* activity_labels.txt (plus sets appriopriate column names)
* X_train.txt
* y_train.txt
* X_test.txt
* y_test.txt 
* subject_train.txt
* subject_test.txt
- merges a 561-feature vector containing time and frequency domain variables (X_train/X_test) with activity label (X_train_labels/X_test_labels) 
and an identifier of the subject who carried out the experiment (subject_train/subject_test) for training/test datasets respectively
- merges full training (train_full) and test (test_full) datasets together into one dataset: step1_full_dataset
- sets appriopriate column names for columns containing following variables: subject identifier, activity label
- output from step 1: step1_full_dataset

### Step 2
- extracts only the measurements on the mean and standard deviation for each measurement
- output from step 2: step2_mean_std_subset

### Step 3
- assigns descriptive activity names to name the activities in the data set (replaces the column with activity id (label.id) with a column with activity name (activity_name) )
- output from step 3: step3_activity_names

### Step 4
- appropriately labels the data set with descriptive variable names taken from features.txt file
- output from step 4: step4_descr_variable_names

### Step 5
- creates an independent tidy data set with the average of each variable for each activity and each subject
- output from step 5: step5_tidy_dataset

### Step 6
- writes final dataset into txt file
- output from step 6: ksenderowska_get_clean_data_project.txt


In the final tidy dataset, for each record it is provided:
======================================

- An identifier of the subject who carried out the experiment.
- An activity name. 
- A 66-feature vector with means and standard deviations of time and frequency domain variables, averaged over each activity and each subject.


Units:
======
- Features are normalized and bounded within [-1,1].

