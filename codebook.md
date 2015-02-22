# codebook

The script run_analysis.R takes the original data from the original data set provided. Details are in README.md

The script adds 3 columns to the data:

##group

The original research divided the test subjects in a group used for training the algorithm ("ham") and a group to run the algorithm on.

The script bundles all measurements of all subjects into one table, this column explains what subset the data came from.


##subject

The data contains measurements from a number of sensors. Measurements were gathered with anonymous test subjects, only identified by a number.

The script does not alter the number, as there is no identifiable information in the data set.


##activity

The different activities by test subjects are shown as a textual label.


##other columns

All other columns are measurements from the original data set. Only the columns with mean and standard deviation were retained. E.g. minimum/maximum data was ignored.

