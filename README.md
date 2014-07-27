getdata-005-assignment
======================
Following repository contains the solution for the assignment from "Getting and Cleaning data" course.

Content of the repository
-------------------------
1. Readme.md - this file, describing the repository
2. run_analysis.R - script performing the analysis on the data set
3. CodeBook.md - file describing the content of run_analysis.md output

Requirements
------------
- R
- Script and data in the same directory
- Data stored in "data" directory

Data Source
-----------
Human Activity Recognition Using Smartphones Data Set 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Following files have been used in analysis:

- activity_labels.txt
- features.txt
- test/X_test.txt
- test/y_test.txt
- test/subject_test.txt
- train/X_train.txt
- train/y_train.txt
- train/subject_train.txt

Output
------
run_analysis.R generates:
- data frame "data" (data set as stated in assignment specification) - merged data source
- data frame "summary" (tidy data set as stated in assignment specification) - summarized data
- file "data.csv" - CSV with the content of data frame "data"
- file "summary.csv" - CSV with the content of data frame "summary"

Measurements transformation
---------------------------
Original measurements (featuers) labels where transformed for better readibility:
- CamelCase has been applied
- Prefixes t and f where replaced by Time and Freq (for Frequency)
- Special characters removed
- Duplicates removed (i.e. BodyBody)
- Acc replaced to Accel (for Accelerometer)

Activities transformation
-------------------------
Activity labels were transformed from upper case to lower case words starting with a uppercase letter.

Behind the scenes
-----------------
Please refer to the script's comments which describe what is happening.
