# ucihar
Human Activity Readings Using Smartphones

The R script run_analysis.R takes two separate data sets from human activity recognition gathered using smartphones. These are 'test' and 'train', and the script merges them into one tidy data set.

From the raw data, the script creates a two-dimensional table based on the human activity readings as the variables. It will add two additional variables, subject and activity at the beginning of the data table.

After the initial table is created, the script will group the data by subject and activity and compute the mean for the rest of the variables. The final table will contain only the mean for each subject per activity.