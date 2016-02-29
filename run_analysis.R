# Creates a tidy set which includes the mean and standard deviation of the 
# training and test data sets. Original source:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


library(dplyr)

# Read the training and test data files, then merge the data set
train <- read.csv("UCI HAR Dataset/train/X_train.txt", header=FALSE, sep = "")
test <- read.csv("UCI HAR Dataset/test/X_test.txt", header=FALSE, sep = "")
mds <- rbind(train, test)

# Read the list of features in the measurements
features <- read.csv("UCI HAR Dataset/features.txt", header=FALSE, sep = "")

# Build a logical matrix for the mean and standard deviation positions
# Find also the 'meanFreq' positions
# Build combined matrix of the mean and std, but exclude meanFreq
mpos <- grepl("mean\\(\\)",features$V2)
spos <- grepl("std\\(\\)",features$V2)
mspos <- (mpos | spos)

# Extract only the columns for the mean and standard deviation
mds2 <- mds[,mspos]
colnames(mds2) <- features$V2[mspos]

# Remove , parentheses, 
# the duplicate "BodyBody", and trailing ".1"
for (i in seq_along(colnames(mds2))) {
    colnames(mds2)[i] <- gsub("\\(\\)", "", colnames(mds2)[i])
    colnames(mds2)[i] <- gsub(".1", "", colnames(mds2)[i])
    colnames(mds2)[i] <- gsub("BodyBody", "Body", colnames(mds2)[i])
}

# Read the training and test activity files, then merge the activities
train_act <- read.csv("UCI HAR Dataset/train/y_train.txt", header=FALSE, sep = "")
test_act <- read.csv("UCI HAR Dataset/test/y_test.txt", header=FALSE, sep = "")
mds_act <- rbind(train_act, test_act)

# Read the list of activity names and change the activity number to these names
act_names <- read.csv("UCI HAR Dataset/activity_labels.txt", header=FALSE, sep = "")
mds_act <- mutate(mds_act, activity = act_names$V2[mds_act$V1])

# Add activity names onto the merged data set
mds3 <- cbind(mds_act$activity, mds2)
colnames(mds3) <- c("activity", colnames(mds3)[2:ncol(mds3)])

# Read the participant IDs, merge them and append them on the data set
train_ind <- read.csv("UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep = "")
test_ind <- read.csv("UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep = "")
mds_ind <- rbind(train_ind, test_ind)
mds4 <- cbind(mds_ind, mds3)
colnames(mds4) <- c("subject", colnames(mds4)[2:ncol(mds4)])

# Write the tidy data file
write.csv(mds4,"tidy.csv", row.names=FALSE)

# Read in the new data set
mds5 <- read.csv("tidy.csv")

# Group data by participant and activity
# find the mean of each variable for each group
mds6 <- mds5 %>%
    group_by(subject, activity) %>%
    summarize_each(funs(mean))

# Add "Avg-" to column names
for (i in 3:ncol(mds6)) {
    colnames(mds6)[i] <- paste("Avg-", colnames(mds6)[i], sep="")
}

# Write the second tidy data set with the average of each variable
write.table(mds6, "tidy2.csv", row.names = FALSE)