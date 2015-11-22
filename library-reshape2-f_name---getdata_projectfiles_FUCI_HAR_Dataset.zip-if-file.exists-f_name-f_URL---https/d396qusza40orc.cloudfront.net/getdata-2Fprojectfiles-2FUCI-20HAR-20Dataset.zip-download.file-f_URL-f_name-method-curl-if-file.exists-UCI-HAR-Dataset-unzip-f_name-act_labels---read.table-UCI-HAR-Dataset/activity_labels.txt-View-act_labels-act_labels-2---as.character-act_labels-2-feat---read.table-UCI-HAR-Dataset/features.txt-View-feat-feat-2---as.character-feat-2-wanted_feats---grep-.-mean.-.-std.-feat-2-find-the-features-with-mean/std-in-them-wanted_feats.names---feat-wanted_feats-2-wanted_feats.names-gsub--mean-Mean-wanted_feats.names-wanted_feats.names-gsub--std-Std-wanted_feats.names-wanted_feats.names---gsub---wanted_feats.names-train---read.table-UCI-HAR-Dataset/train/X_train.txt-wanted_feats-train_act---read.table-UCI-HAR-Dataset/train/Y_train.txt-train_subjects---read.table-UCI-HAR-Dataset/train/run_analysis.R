library(reshape2)

f_name <- "getdata_projectfiles_FUCI_HAR_Dataset.zip"

if (!file.exists(f_name)){
  f_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(f_URL, f_name, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(f_name) 
}


act_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
View(act_labels)
act_labels[,2] <- as.character(act_labels[,2])

feat <- read.table("UCI HAR Dataset/features.txt")
View(feat)
feat[,2] <- as.character(feat[,2])

wanted_feats <- grep(".*mean.*|.*std.*", feat[,2]) #find the features with mean/std in them
wanted_feats.names <- feat[wanted_feats,2]
wanted_feats.names = gsub('-mean', 'Mean', wanted_feats.names)
wanted_feats.names = gsub('-std', 'Std', wanted_feats.names)
wanted_feats.names <- gsub('[-()]', '', wanted_feats.names)


train <- read.table("UCI HAR Dataset/train/X_train.txt")[wanted_feats]
train_act <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train_subjects, train_act, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[wanted_feats]
test_act <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test_subjects, test_act, test)

merged_data <- rbind(train, test)
colnames(merged_data) <- c("subject", "activity", wanted_feats.names)

merged_data$activity <- factor(merged_data$activity, levels = act_labels[,1], labels = act_labels[,2])
merged_data$subject <- as.factor(merged_data$subject)

merged_data.melted <- melt(merged_data, id = c("subject", "activity"))
merged_data.mean <- dcast(merged_data.melted, subject + activity ~ variable, mean)

write.table(merged_data.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
