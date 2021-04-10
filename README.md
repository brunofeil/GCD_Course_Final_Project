# GCD_Course_Final_Project

## How the script work
There are several comments in the R script explaining how the script work (the functions and the steps to get the tidy data set exported). So I'm gonna use this readme file to explain the variables in the Script

### The variables (in order of appearance)

train_data -> train data set
test_data -> test data set
merged_df -> train and test data set merged together

features -> names of the features

mean_std_df -> merged dataframe only containing the mean and standard deviations variables

activity_train -> activities train data set
activity_test -> activities test data set
merged_activity -> train and test activities merged together

labeled_activity -> activities dataframe containing the label of the activities and not the number of the activity

subject_train -> subject train data set
subject_test -> subject test data set
merged_subject -> train and test subjects merged together

grouped_df -> dataframe grouped by activity and subject

summarised_data -> tidy data set grouped by activity and subject containing the average values of each variable
