library(dplyr)
##Read in two text files that contain information about dataset
ActivityDesc<-read.table("activity_labels.txt")
FeatureVar<-read.table("features.txt")
#Read in three text files that contain test data variables
#Rename columnnames so unique and identify first two variables
#Combine three text files together to create complete test data set
Xtest<-read.table("./test/X_test.txt")
ytest<-read.table("./test/y_test.txt")
ytest<-rename(ytest,ActivityNum=V1)
subjecttest<-read.table("./test/subject_test.txt")
subjecttest<-rename(subjecttest,SubjectID=V1)
test1<-cbind(ytest,Xtest)
testdata<-cbind(subjecttest,test1)
#Read in three text files that contain train data variables
#Rename columnnames so match columnnames in test data set
#Combine three text files together to create complete train data set
Xtrain<-read.table("./train/X_train.txt")
ytrain<-read.table("./train/y_train.txt")
ytrain<-rename(ytrain,ActivityNum=V1)
subjecttrain<-read.table("./train/subject_train.txt")
subjecttrain<-rename(subjecttrain,SubjectID=V1)
train1<-cbind(ytrain,Xtrain)
traindata<-cbind(subjecttrain,train1)
#Combine rows of test and train data set to create step1 project data set
projectDataset<-rbind(testdata,traindata)
#Identify column positions in original measurement data set that contain variable measurements identified in codebook
step2subset<-grep("*mean*|*std*",FeatureVar$V2)
step2subsetcol<-step2subset+2 #Adjust column positions to include new first two variables subjectID and Activity
#Create new dataframe skeleton and content for steps 2-4
#Transfer first two columns of step1 project data set. 
#Use merge to lookup activity label in ActivityDesc based on ActivityNum and create new column with labels
#Exclude original Activity column with ID number for activity
Step2Dataset<-select(projectDataset,SubjectID:ActivityNum)
Step3Dataset<-merge(Step2Dataset,ActivityDesc,by.x="ActivityNum",by.y="V1")
Step3Dataset<-rename(Step3Dataset,Activity=V2)
Step3Dataset<-select(Step3Dataset,SubjectID:Activity)
#Select columns in original measurement data set that contain variable measurements identified in codebook
colsubset<-select(projectDataset,step2subsetcol)
#Select original variable labels for variable measurements identified in codebookin Feature.txt
#Edit variable labels to remove () and - and create names in codebook.
#Assign edited names in codebook to corresponding columns in dataframe
DescColnames<-FeatureVar[step2subset,2]
DescColnames<-gsub("-","",DescColnames)
DescColnames<-gsub("()","",DescColnames,fixed=TRUE)
colnames(colsubset)<-DescColnames
#Combine the first two updated columns with the identified subset of variable measurements
#Step4Dataset is the first tidy data set for this project
Step4Dataset<-cbind(Step3Dataset,colsubset)
#Create a second independent tidy data set to address step 5
#Step5TidyDataset contains the average of each variable for each activity and each subject
Step5Dataset<-Step4Dataset
Step5TidyDataset<-Step5Dataset%>%group_by(SubjectID,Activity)%>%summarise_each(funs(mean))
#With 30 subjects and 6 activities, there should be 180 observations in second tidy data set
#There are 30 variables associated with timeXYZ measurements, 27 variables with frequencyXYZ,
#12 variables with frequencyMagnitude measurements and 10 variables with timeMagnitude.
#Thus there should be 79 variable measurement columns plus 2 ID columns
dim(Step5TidyDataset)
names(Step5TidyDataset)