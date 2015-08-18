library(dplyr)

readSubjectActivityData <- function(mode="test") {
    #Get data values
    x <- read.table(paste(mode, "/X_", mode, ".txt", sep=''))
    #Get activity rows
    y <- read.table(paste(mode, "/y_", mode, ".txt", sep=''))
    #Get column variables
    features <- read.table("features.txt")
    #Set column names - Use descriptive activity names to name the activities in the data set
    namedX <- setNames(x, features$V2)
    #Get labels for activity rows
    activityLabels <- read.table("activity_labels.txt")
    #Merge label names with corresponding values
    yLabeled <- merge(y, activityLabels, all = TRUE)
    #Use labels as rows in a new column
    activityData <- cbind(activity = yLabeled$V2, namedX)
    #Load subjects
    subject <- read.table(paste(mode, "/subject_", mode, ".txt", sep=''))
    #Add subject as a variable in the data set
    subjectData <- cbind(subject = subject$V1, activityData)
    
    return(subjectData)
}

generateAverageData <- function(dataSet) {
    # generate mean of variables (columns) 
    dataSet %>% 
        group_by(subject, activity) %>% #group by subject and activity
        summarise_each(funs(mean)) %>% #get the mean of all columns
        return
}

#Read data sets for test and for train
testSubject <- readSubjectActivityData()
trainSubject <- readSubjectActivityData("train")

#Merge the training and the test sets to create one data set.
mergeData <- rbind(testSubject, trainSubject)

#Filter, extract only the measurements on the mean and standard deviation for each measurement.
meanStdOnly <- mergeData[, grep("activity|subject|mean|Mean|std", colnames(mergeData))]

#From the data set, create a second, independent tidy data set with the average of each variable for each activity and each subject.
newData <- generateAverageData(meanStdOnly)
write.table(newData, file="run_analysis_tidy_data.txt")