run_analysis <- function(){
        
        ## Step 1 - loading train measurements
        train <- read.table(file = "data/train/X_train.txt")
        train <- cbind(train, read.table(file = "data/train/subject_train.txt"))
                
        trainactivityref <- read.table(file = "data/train/y_train.txt") ## Step 3 loading train reference for activities
        
        trainactivity <- vector() ## Step 3 a vector to change the reference number for string
        
        ## Step 1 - loading test measurements
        test <- read.table(file = "data/test/X_test.txt")
        test <- cbind(test, read.table(file = "data/test/subject_test.txt"))
                
        testactivityref <- read.table(file = "data/test/y_test.txt") ## Step 3  loading test reference for activities
        
        testactivity <- vector() ## Step 3 a vector to change the reference number for string 
        
        activity <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING") ## Step 3 a vector with the activity name strings
        
        ## Step 3 loops to change numbers for names
        
        for (i in 1:nrow(trainactivityref)){
                trainactivity[i] <- activity[trainactivityref[i,1]]       
        }
        
        for (i in 1:nrow(testactivityref)){
                testactivity[i] <- activity[testactivityref[i,1]]       
        }
        
        ## Step 3 Loading the name activities to the data frame
        train <- cbind(train, trainactivity)
        
        test <- cbind(test, testactivity)
        
        ## Step 4 - removing "(",")","-" and ",".
        measurementsnames <- read.table(file = "data/features.txt", colClasses = "character")
        
        colNames <- gsub("[,()-]","",measurementsnames[,2])
                
        colNames[562] <- "subject"
        colNames[563] <- "activity_label"
        
        colnames(train)<- colNames
        colnames(test)<- colNames
        
        ##Merging full data
        MFD <- rbind(train, test)
        
        ## Step 2 - extracting only the interest measurements
        interestmeasurements <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,161,162,162,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,542,543,562,563)
        
        measurementsdata <- data.frame()
        
        for(i in 1:length(interestmeasurements)){
                if(i == 1){
                        measurementsdata <- MFD[interestmeasurements[i]]
                }else{
                        measurementsdata <- cbind(measurementsdata, MFD[interestmeasurements[i]])
                }
                
        }
        
        ## Step 5 - Create a tidy data
        
        subjectmelt <- melt(measurementsdata, id=c("subject", "activity_label"))
        
        tidydata <- dcast(subjectmelt, subject + activity_label ~ variable, mean)
        
        write.table(tidydata, file="data/course_project_tidy_data.txt", sep = ",")        
        
}