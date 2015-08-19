# ucihar
Human Activity Readings Using Smartphones

The R script run_analysis.R takes two separate data sets from human activity recognition gathered using smartphones. These are 'test' and 'train', and the script merges them into one tidy data set.

Make sure the data set is in the same directory as the R script, with test and train directories as subdirectories. 

From the raw data, the script creates a two-dimensional table based on the human activity readings as the variables. It will add two additional variables, subject and activity at the beginning of the data table.

After the initial table is created, the script will group the data by subject and activity and compute the mean for the rest of the variables. The final table will contain only the mean for each subject per activity.

For each of these data sets, we have raw data:

* activity_labels.txt correspond to descriptive names  for activities. This will reflect as rows in one variable in the data set that we are building (not the raw data).

* y_test.txt /y_train.txt is the numeric representation of the activities. Each will correspond to one row in the data set.

* subject_test.txt /subject_train.txt is representative of the people who have produced the human activity. This also represents one row each in the data set.

* features.txt will be the variables or columns representing the descriptive names of our data set's human activity readings.

* X_test.txt /X_train.txt represents the human activity readings for the different variables. This will be the main data set for the raw data.


First, we need to load the dplyr library:

library(dplyr)

To create the table with descriptive variable names corresponding to the human activity readings, we use a function called

readSubjectActivityData <- function(mode="test") 

Which can be used in either test (default) or train data.

So the function works as follows:
 
* We will read the X and Y data, and add the features as the column headings like  tBodyAcc-mean()-X, tBodyAcc-mean()-Y, etc.

* After that we will use the activities as an additional variable /column, but instead of the numeric value, we'll use the descriptive values like "WALKING".

* We will then add the subjects as another variable /column. These are numbers so we keep them as is.
 
We use this function to read the data sets for test and train and store them to variables, like this:

testSubject <- readSubjectActivityData()
trainSubject <- readSubjectActivityData("train")

After that we merge them using rbind. We don't need all the variables so we filter only those related to mean and standard deviation. We now have a combined and filtered data set.

From this data set, we generate a new table that only has the mean or average of each human activity reading, per subject per activity. We will use the function

generateAverageData <- function(dataSet) 

In this function, the final data set can be achieved using group_by and summarise_each.

We then save it to a file called "run_analysis_tidy_data.txt" using write.table.