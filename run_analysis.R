# File paths
baseDir <- 'data/UCI HAR Dataset/'

trainFiles <- list(
    data=paste0(baseDir, 'train/X_train.txt'),
    activity=paste0(baseDir, 'train/y_train.txt'),
    subject=paste0(baseDir, 'train/subject_train.txt')
)

testFiles <- list(
    data=paste0(baseDir, 'test/X_test.txt'),
    activity=paste0(baseDir, 'test/y_test.txt'),
    subject=paste0(baseDir, 'test/subject_test.txt')
)

referenceFiles <- list(
    features=paste0(baseDir, 'features.txt'),
    activityLabels=paste0(baseDir, 'activity_labels.txt')
)

processSet <- function(dataFiles, reference, type) {
    localData <- data.frame()
    dataFile <- dataFiles$data
    activityFile <- dataFiles$activity
    subjectFile <- dataFiles$subject

    featuresFile <- reference$features
    activityLabelsFile <- reference$activityLabels

    #
    # Reading training files.
    #
    print(paste('Reading main data file:', type))
    localData <- read.fwf(dataFile, widths=rep(16, 561))

    # Yes, I could've just read this once.
    print('Reading features name file')
    features <- read.csv(featuresFile, sep=' ', header=F)

    # Setting colum names for easy reference.
    colnames(features) <- c('id', 'name')

    # setting column names based on the features.txt file.
    colnames(localData) <- features$name

    # selecting the mean/std columns
    localData <- localData[,grepl('\\<mean\\>|\\<std\\>', colnames(localData))]

    # The data in localData is from a train/test set, we classify it as such
    # NOT required, but I think it'd provide
    #localData$source <- type
    
    #
    # Activity labels are in y_train.txt
    #
    print('Reading activities')
    activityLabels <- read.csv(activityLabelsFile, header=F, sep=' ')
    activity <- read.csv(activityFile, header=F)

    # Column names for clear reference
    colnames(activityLabels) <- c('id', 'label')
    colnames(activity) <- c('id')

    localData$activity <- merge(activity, activityLabels, by='id', all=T)[,'label']
    
    #
    # Merging subjects
    #
    print('Reading subjects')
    subject <- read.csv(subjectFile, header=F)
    localData$subject <- subject[[1]]

    # localData has everything now.
    localData
}

data <- processSet(trainFiles, referenceFiles, 'train')
test <- processSet(testFiles, referenceFiles, 'test')

full <- rbind(data, test)

# Output file
cleanFileNoNames <- 'clean/data.csv'

# Create output dir if it doesn't exists
if (!dir.exists('clean')) {
    dir.create('clean')
}

# Write the consolidated data set.
write.csv(full, file=cleanFileNoNames, sep=',', row.names=F)
