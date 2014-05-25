# Readme
The "run_analysis.R" script provided in this repository is an R script that takes part of the provided input files, extract some of the features measured by smartphone accelerometers and gyroscope, reshapes and aggregates them in an output tidy data set. 
## List of no standard R library used
The script uses two no standard R libraries: 
* reshape2 (to melt data)
* sqldf (to query data with SQL Language)
## List of input files used and output files produced
All files listed below have been provided for the Course Project Assignment; they are input for the script, all must be present in Working Directory:
* X_test.txt (test data)
 * X_train.txt (train data)
 * subject_test.txt (subjects of test data)
  * subject_train.txt (subjects of train data)
  * y_test.txt (activities of test data)
  * y_train.txt (activities of train data)
  * activity_labels.txt (labels of activities)
  * features.txt (labels of features)
The script produces the output file "run_analysis_output.txt", located in Working Directory. The file structure is the same as output tidy data set, described in CodeBook.md.
## Script Description
The provided script performs the following steps in sequence:
* Loads all needed libraries
* Reads all needed input files in Working Directory
* Puts together test and train data (subjects, features, activities)
* Finds and extracts all the features with strings "mean()" and "std()" in the name (exact match)
* Reshapes the features names
* Puts together subjects, activities and variables
* Merges data with activity labels to take descriptive names for activities
* Melts to obtain a first intermediate tidy data set
* Aggregates by average to obtain a final output tidy data set 
* Writes "run_analysis_output.txt" file in Working Directory
* Returns the second tidy data set
