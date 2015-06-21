##Running the script
To get tidy data from the experiments:

0. The script expects working directory set such that it finds "test" and "train" directories on the same path
1. load dpylr
2. source("run_analysis.R")
3. tidy <- getTidyData()


## Data book
tidy data is a DF which columns are:
1. subject_id : same as subject id from source 
2. activity name: activity string label
3 to 67: the subset of source features that relate to mean() and std().

##Implementation

The function getTidyDataSet receives either "test" or "train"
it returns a tidy data set, then getTidyData simply does an rbind of
these two tidy DF.


#getTidyDataSet
1. Reads features.txt and activity_labels.txt into DF.


2. Reads actual data from experiments:
read actual data from experiment which are originaly splitted among
several files: (subject, activity, all other columns). All of this have the same number of rows and are the whole data that has to be
tidy.

3. activity IDs are merged with activity labels 

4. using filter, we get data related to cols with mean() or std() on their names

5. All of the DF are binded with cbind

6. resulting DF is colnamed
