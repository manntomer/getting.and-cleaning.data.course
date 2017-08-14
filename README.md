This is the course project for the "Getting and Cleaning Data"  course. 

The script, run_analysis.R, performs the following data manipulation:
  
Download the dataset into the working directory
Loads the requested activity and feature info
Loads  the training and test datasets, keeping only columns that massure either mean or standard deviation
Loads the activity and subject data for each dataset, and merges those columns with the coresponding dataset
Merges both datasets into one
Creates a tidy dataset that consists of the average value of each variable for each subject and activity type.
The result is the table "tidy.data""