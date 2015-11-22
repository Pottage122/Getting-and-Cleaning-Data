# Getting and Cleaning Data - Project

This is for the Getting and Cleaning Data Coursera course project.
The `run_analysis.R` script has the following operations:

1. Downloads the dataset if it does if not already in the working directory.
2. Loads the activity and feature information.
3. Loads both the training and test datasets, keeping only the columns which
   have any mean or standard deviation data.
4. Loads the activity and subject data for each dataset, and merges those
   columns with the dataset.
5. Merges the two datasets.
6. Converts the `activity` and `subject` columns into factors.
7. Creates a tidy dataset that has the average (mean) value of each
   variable for each subject and activity pair.

A file called `tidy.txt` is created containing the final dataset.
