# Read activity labels and transform them to "normal" case word, e.g. "WALKING to Walking"
activity_labels <- read.csv("data//activity_labels.txt", header = FALSE, sep = ' ')
activity_labels <- sub('^(\\w?)', '\\U\\1', tolower(gsub("_", " ", activity_labels[,2])), perl=T)
activity_labels <- data.frame(c(1:6), activity_labels)
activity_labels <- setNames(activity_labels, c("ID", "Activity"))

# Read features labels
features <- read.csv("data//features.txt", header = FALSE, sep = ' ')[,2]

# Read test data
x_test <- read.table("data/test/X_test.txt", header = FALSE, col.names = features)
y_test <- read.table("data/test/y_test.txt", header = FALSE, col.names = c("ID"))
subject_test <- read.table("data/test/subject_test.txt", header = FALSE, col.names = c("Subject"))

# Read training data
x_train <- read.table("data/train/X_train.txt", header = FALSE, col.names = features)
y_train <- read.table("data/train/y_train.txt", header = FALSE, col.names = c("ID"))
subject_train <- read.table("data/train/subject_train.txt", header = FALSE, col.names = c("Subject"))

# Merge test and training lists of subjects
subject <- rbind(subject_test, subject_train)

# Clean up
rm(subject_test)
rm(subject_train)

# Merge test and training lists of activities
activity <- rbind(y_test, y_train)
# Add index
activity$idx <- 1:nrow(activity)
# Replace ID's with activities labels
activity <- merge(activity, activity_labels, by.x='ID', by.ID='ID')
# Reorder to the original order (using index)
activity <- activity[order(activity$idx), ]
# Leave only column with the description
activity <- subset(activity, select = c("Activity"))

# Clean up
rm(y_test)
rm(y_train)
rm(activity_labels)

# Leave only mean and standard deviation data
x_test <- x_test[,grep("mean\\(|std\\(", features)]
x_train <- x_train[,grep("mean\\(|std\\(", features)]

# Merge test and training measurements
measurements <- rbind(x_test, x_train)

# Clean up
rm(x_test)
rm(x_train)

# Transform features labels:
# - Leave only mean and standard devation
features <- features[grep("mean\\(|std\\(", features)]
# - BodyBody -> Body
features <- gsub("BodyBody", "Body", features)
# - t -> Time
features <- gsub("^t", "Time", features, perl = TRUE)
# - f -> Freq
features <- gsub("^f", "Freq", features, perl = TRUE)
# - Acc -> Accel
features <- gsub("Acc", "Accel", features, perl = TRUE)
# - CamelCase
features <- gsub("-(\\w)(\\w+)\\(\\)(-?)", "\\U\\1\\L\\2", features, perl = TRUE)

# Add labels to measurements
measurements <- setNames(measurements, features)

# Create data frame from: subjects list, activities list and measurements
data <- data.frame(subject, activity, measurements)
data <- data[order(data$Subject, data$Activity), ]
row.names(data) <- NULL

# Clean up
rm(subject)
rm(activity)
rm(measurements)
rm(features)

# Save "data"
write.csv(data, "data.csv", row.names = FALSE)

# Calculate mean value for all measurements per subject and activity
summary <- aggregate(. ~ Subject + Activity, data=data, FUN=mean, na.action = na.omit)
summary <- summary[order(summary$Subject, summary$Activity), ]
row.names(summary) <- NULL

# Save "summary data"
write.csv(summary, "summary.csv", row.names = FALSE)