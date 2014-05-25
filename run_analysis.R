run_analysis<-function() {
  ## Load all needed libraries
  library(reshape2)
  library(sqldf)
  ## Read all needed files
  test<-read.table("X_test.txt")
  train<-read.table("X_train.txt")
  test_subject<-read.table("subject_test.txt")
  train_subject<-read.table("subject_train.txt")
  test_action<-read.table("y_test.txt")
  train_action<-read.table("y_train.txt")
  label<-read.table("activity_labels.txt",col.names=c("actioncode","activity"))
  features<-read.table("features.txt",stringsAsFactors=FALSE)
  ## Put together test and train data
  allsubject<-rbind(train_subject,test_subject)
  names(allsubject)<-c("subject")
  allaction<-rbind(train_action,test_action)
  names(allaction)<-"actioncode"
  alldata<-rbind(train,test)
  ## Find and extract all the measurements with "mean()" and "std()" in the name
  col<-rbind(features[grep("mean()",features$V2,fixed=TRUE),],features[grep("std()",features$V2,fixed=TRUE),])$V1
  data<-alldata[,col]
  ## Reshape the measurements names
  name<-gsub("std\\(\\)","Std",features[col,]$V2)
  name<-gsub("mean\\(\\)","Mean",name)
  name<-gsub("-","",name)
  names(data)<-name
  ## Put together subjects, activities and variables
  dati<-cbind(allsubject,allaction,data)
  ## Merge data with activity labels to take descriptive names for activities
  dati<-merge(dati,label,by="actioncode",sort=FALSE)
  ## Melt to obtain the first tidy data set
  tidy<-melt(dati,id=names(dati)[c(2,69)],measure.vars=names(dati)[3:68])
  ## Aggregate to obtain the second tidy data set 
  tidy2<-sqldf("SELECT subject, activity, variable, AVG(value) AS value FROM tidy GROUP BY subject, activity, variable ORDER BY subject, activity, variable")
  ## Write .txt file in workdir
  write.table(tidy2,"run_analysis_output.txt",row.names=FALSE,quote=FALSE)
  ## Return the second tidy data set
  return(tidy2)
}