Getting and cleanind data course project
========================================

Course Project for Getting and Cleaning Data Class

The run_analysis.R script do the follow:

- First it load data from files in the <workdirectory>/data/. Reading the data in a specific order, first the train files and then the test files. Each one in a data table like train and test respectivily.

- Load an activity reference using the file y_train.txt and y_test.txt that refers the number for the activity and change this number informed in this files for the name of the activity shown in the file activity_labels.txt loaded in another vector.

- Load the names of variables into a data table. Convert this data table into a character vector removing special characters as "(),-" called colNames. Add two more variables for subject and activity label.

- Merge the full data. 

- Create a vector with the interest variables of the merged data and select this data into a new data frame.

- Finally create a tidy data file.
