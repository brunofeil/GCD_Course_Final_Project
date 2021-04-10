library(dplyr)

## =============================================================
#  Functions 
## =============================================================

# Get the training data set
get_training_data <- function()
{
    ## Load the training set into memory
    old.dir <- getwd()
    setwd("train")
    train_data <- read.table("X_train.txt", header = FALSE)
    setwd(old.dir)
    
    ## Load the features set
    features <- read.table("features.txt", header = FALSE)
    
    ## Name the features
    names(train_data) <- features$V2
    
    return(train_data)
}

# Get the test data set
get_test_data <- function()
{
    ## Load the test set into memory
    old.dir <- getwd()
    setwd("test")
    test_data <- read.table("X_test.txt", header = FALSE)
    setwd(old.dir)
    
    ## Load the features set
    features <- read.table("features.txt", header = FALSE)
    
    ## Name the features
    names(test_data) <- features$V2
    
    return(test_data)
}

# Merge the train and test data sets into one
train_test_merge <- function(train, test)
{
    # Merge the datasets (concatenate them horizontally)
    return(rbind(train, test))
}

# Get only the mean and standard deviation columns of the data set
get_mean_std <- function(df, features_names)
{
    # Get the columns that contains "mean()" or "std()" in the name
    mean_std_col <- grep("(mean\\(\\))|(std\\(\\))", features_names)
    return(df[,mean_std_col])
}

# Get the activity train data
get_activity_train_data <- function()
{
    ## Load the test set into memory
    old.dir <- getwd()
    setwd("train")
    activity_train_data <- read.table("y_train.txt", header = FALSE)
    setwd(old.dir)
    
    return(activity_train_data)
}

# Get the activity test data
get_activity_test_data <- function()
{
    ## Load the test set into memory
    old.dir <- getwd()
    setwd("test")
    activity_test_data <- read.table("y_test.txt", header = FALSE)
    setwd(old.dir)
    
    return(activity_test_data)
}

# label the activities based on their number
name_activity <- function(to_be_named)
{
    activity_label <- read.table("activity_labels.txt")
    
    named <- activity_label[to_be_named[,1],2]
    
    return(named)
}

# Get the subject train data
get_subject_train_data <- function()
{
    ## Load the test set into memory
    old.dir <- getwd()
    setwd("train")
    subject_train_data <- read.table("subject_train.txt", header = FALSE)
    setwd(old.dir)
    
    return(subject_train_data)
}

# Get the subject test data
get_subject_test_data <- function()
{
    ## Load the test set into memory
    old.dir <- getwd()
    setwd("test")
    subject_test_data <- read.table("subject_test.txt", header = FALSE)
    setwd(old.dir)
    
    return(subject_test_data)
}

## 1. Merge the training and test data set
train_data <- get_training_data()
test_data <- get_test_data()
merged_df <- train_test_merge(train_data, test_data)

## 2. Extract the measurements on the mean and std for each measurement
## Load the features set
features <- read.table("features.txt", header = FALSE)
mean_std_df <- get_mean_std(merged_df, features$V2)

## 3. Name the activities using descriptive activity names

# Get the train and test activities
activity_train <- get_activity_train_data()
activity_test <- get_activity_test_data()

# Merge them together
merged_activity <- train_test_merge(activity_train, activity_test)

# Label the activities
labeled_activity <- name_activity(merged_activity)

## 4. Label the data set with the descriptive variable names

# Add a new column in the dataframe containing the activities label
mean_std_df <- mutate(mean_std_df, activity = labeled_activity)

# 5. Create a tidy dataset with the average of each variabl for each activity
# Get the subjects id and add them into the dataframe
subject_train <- get_subject_train_data()
subject_test <- get_subject_test_data()

# Merge them together
merged_subject <- train_test_merge(subject_train, subject_test)

# Add the subjects into the dataframe
mean_std_df <- mutate(mean_std_df, subject = merged_subject)

# Group the dataframe by activity and subject
grouped_df <- group_by(mean_std_df, activity, subject)

# Summarise the grouped by activity and subject dataframme by calculating the average (mean) of each variable
summarised_data <- summarise_each(grouped_df, mean)

write.table(summarised_data, file = "tidy_data_set.txt", row.names = FALSE)
