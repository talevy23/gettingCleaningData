run_analysis <- function(directory="data/UCI HAR Dataset"){
  # Read train/test sets
  train<-read.table(paste0(directory,"/train/X_train.txt"))
  test<-read.table(paste0(directory,"/test/X_test.txt"))
  
  ## 1. Merges the training and the test sets to create one data set.
  data<-rbind(train,test)
  
  ## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  # Read column names
  features<-read.table(paste0(directory,"/features.txt"))
  # Find mean() and std() columns numbers
  mean_stdCols<-grep("mean\\(\\)|std\\(\\)",features[,2])
  # take data only from these columns
  data<-data[,mean_stdCols]
  
  ## 3. Uses descriptive activity names to name the activities in the data set
  # get features names
  features<-features[mean_stdCols,2]
  # uppercase mean/std 
  features<-gsub("mean\\(\\)","Mean",features)
  features<-gsub("std\\(\\)","Std",features)
  # remove "-" 
  features<-gsub("-","",features)
  # 't' to 'time' ; 'f' to 'frequency'
  features<-gsub("^t","time",features)
  features<-gsub("^f","frequency",features)
  # 'BodyBody' to 'Body'
  features<-gsub("BodyBody","Body",features)
  
  ## Assign features as names
  names(data)<-features
  
  
  ## 4. Appropriately labels the data set with descriptive variable names.
  # get train/test activity lables
  train_labels<-read.table(paste0(directory,"/train/y_train.txt"))
  test_labels<-read.table(paste0(directory,"/test/y_test.txt"))
  # union the lables with 'label' name
  labels<-rbind(train_labels,test_labels)
  names(labels)<-"label"
  # integers to label description
  label_names<-read.table(paste0(directory,"/activity_labels.txt"),stringsAsFactors = FALSE)
  labels<-label_names[labels$label,2]
  # add them to data
  data <- cbind(data,labels)

  ## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  # new data with subjects
  train_subjects<-read.table(paste0(directory,"/train/subject_train.txt"))
  test_subjects<-read.table(paste0(directory,"/test/subject_test.txt"))
  subjects<-rbind(train_subjects,test_subjects)
  names(subjects)<-"subjects"
  tidy_data<-cbind(data,subjects)
  # average of each variable for each activity and each subject
  library(dplyr)
  tidy_data<-tidy_data %>% group_by(labels,subjects) %>% summarise_each(funs(mean))

  #output
  write.table(tidy_data,file = "talLevy.txt", row.names = FALSE)    
  tidy_data
}