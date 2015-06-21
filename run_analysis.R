## Given an experiment directory, tidy 


getTidyDataSet <- function(etype, nrows=-1){
	#etype select the data source: Either 'test' or 'train'
	#nrows param may be diff. than 1 for testing purposes, as
	#reading the whole txt files is slow.

	#read labels/numbers relations
	features_labels <- read.csv("features.txt", sep="", header=FALSE)
	activity_labels <- read.csv("activity_labels.txt", sep="", header=FALSE)

	
	#--- read actual data from experiment, the next objects all should have
	# the same number of rows, as they represnt the whole experiment, splitted
	# among thre files (subject, activity, all other columns)

	#subject data holds rows with a single column: subject id
	subject_data <- read.csv(paste("./", etype, "/subject_", etype, ".txt", sep=""), header=FALSE, nrows=nrows)
	#rows with a single column: activity id
	activity_data <- read.csv(paste("./", etype, "/y_", etype, ".txt", sep=""), header=FALSE, nrows=nrows)
	#actual experiment data, we should have 561 (dim(features_labels)) entries per row
	#using sep="" on read.csv as the file contains different number of spaces to separate cols.
	exp_data <- read.csv(paste("./", etype, "/X_", etype, ".txt", sep=""), sep="", header=FALSE, nrows=nrows)
	#---

	#tidy activity labels by turning numbers into names
	activity_data_tidy <- select(merge(activity_data, activity_labels), V2)
	
	#get labels names having the word mean() in it
	means_labels <- filter(features_labels, grepl("mean()", V2, fixed=TRUE))
	#get labels names having the word std() in it
	stds_labels <- filter(features_labels, grepl("std()", V2, fixed=TRUE))

	#append subject data, activity and the rest of columns into a tidy set
	tidy <- cbind(subject_data, activity_data_tidy, select(exp_data, c(means_labels$V1, stds_labels$V1) ))

	#set names for the tidy DF
	colnames(tidy) <- c("subject_id", "activity", array(means_labels$V2), array(stds_labels$V2))

	tidy

}


getTidyData <- function(){
	rbind(getTidyDataSet("test"), getTidyDataSet("train"))

}

getSummary <- function(data)
{
	y <- group_by(data, subject_id, activity)
	summarise_each(y, funs(mean))
}

