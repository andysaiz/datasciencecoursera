#Step 1: download and unzip file
projurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
wd <- as.character(getwd())
download.file(projurl, destfile = paste(wd, "week3assignment.zip", sep = "/"), method = "curl")
unzip("week3assignment.zip")

#Step 2: read each file into a data table
library(data.table)
features <- fread("/Users/saizac/Documents/Coursera_R/Module_3/datasciencecoursera/UCI HAR Dataset/features.txt",
                  col.names = c("n", "measurement"))
features <- features$measurement
X_test <- fread("/Users/saizac/Documents/Coursera_R/Module_3/datasciencecoursera/UCI HAR Dataset/test/X_test.txt",
                col.names = features)
y_test <- fread("/Users/saizac/Documents/Coursera_R/Module_3/datasciencecoursera/UCI HAR Dataset/test/y_test.txt",
                col.names = "code")
X_train <- fread("/Users/saizac/Documents/Coursera_R/Module_3/datasciencecoursera/UCI HAR Dataset/train/X_train.txt",
                col.names = features)
y_train <- fread("/Users/saizac/Documents/Coursera_R/Module_3/datasciencecoursera/UCI HAR Dataset/train/y_train.txt",
                col.names = "code")
activity_labels <- fread("/Users/saizac/Documents/Coursera_R/Module_3/datasciencecoursera/UCI HAR Dataset/activity_labels.txt",
                col.names = c("code", "activity"))
subject_test <- fread("/Users/saizac/Documents/Coursera_R/Module_3/datasciencecoursera/UCI HAR Dataset/test/subject_test.txt",
                col.names = "subject")
subject_train <- fread("/Users/saizac/Documents/Coursera_R/Module_3/datasciencecoursera/UCI HAR Dataset/train/subject_train.txt",
                col.names = "subject")

#Step 3: merge the datasets
merged_X <- rbind(X_train, X_test)
merged_y <- rbind(y_train, y_test)
merged_subject <- rbind(subject_train, subject_test)
merged_data <- cbind(merged_subject, merged_y, merged_X)

#Step 4: Select mean and std columns
library(dplyr)
tidydata <- merged_data %>% select(subject, code, contains("mean"), contains("std"))

#Step 5: rename the columns to fit tidy data principles
#subsetting the activity: matches the code in activity_labels to the rows in tidydata$code and then inserts the labels
tidydata$code <- activity_labels[tidydata$code, 2]

#Step 6: change column names to be more descriptive
names(tidydata)[2] <- "activity"
names(tidydata) <- gsub("Acc", "Accelerometer", names(tidydata))
names(tidydata) <- gsub("Gryo", "Gyroscope", names(tidydata))
names(tidydata) <- gsub("^t", "Time", names(tidydata))
names(tidydata) <- gsub("^f", "Frequency", names(tidydata))
names(tidydata) <- gsub("angle", "Angle", names(tidydata))
names(tidydata) <- gsub("gravity", "Gravity", names(tidydata))
names(tidydata) <- gsub("Mag", "Magnitude", names(tidydata))
names(tidydata) <- gsub("-mean()", "Mean", names(tidydata), ignore.case = TRUE)
names(tidydata) <- gsub("-freq()", "Frequency", names(tidydata), ignore.case = TRUE)
names(tidydata) <- gsub("-std", "STD", names(tidydata), ignore.case = TRUE)
names(tidydata) <- gsub("BodyBody", "Body", names(tidydata))
names(tidydata) <- gsub("tBody", "TimeBody", names(tidydata))

#Step 7: Find averages for each activity and subject
Final <- tidydata %>%
        group_by(subject, activity) %>%
        summarize_all(.funs = ~mean(.))

#Step 8: Write the new dataset to a text file
write.table(Final, "tidy_data.txt")
