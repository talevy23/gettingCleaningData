# gettingCleaningData
NOTES
=================
The script run_analysis.R has a default value of "data/UCI HAR Dataset" for the parameter 'directory'.
If the data is in a different directory, please assign the correct value.

Steps in the code
=================
1. Read and merge train/test sets
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names (from features file) to name the activities in the data set
- Changes "mean()" to "Mean"
- Removes "-"
- Replaces prefix "f" with "frequency" and "t" with "time"
- Replaces "BodyBody" with "Body"
4. Appropriately labels the data set with descriptive variable names.
- labels column name is "label"
- labels values correspond to the activities in "activity_labels.txt" in the original data.
5. Tidy data set is the average of each variable for each activity and each subject.
- subjects column name is "subjects"
