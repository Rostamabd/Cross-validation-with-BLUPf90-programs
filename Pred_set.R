### This Rscript assings individuals to training and testing populations (5-fold cross-validation and 5 Replications)
rm(list=ls())

## five-fold CV and 5 replications (25 analyses) 
for (counter in 1:25){

	### Load phenotypic Data
	Phen <- read.table("data.txt", header=F)
	colnames(Phen) <- c("id", "gen","phen", "TBV","BLUP")

	### Retrive testing set individuals
	testfile <- paste(counter,"testing_samples.data",sep="")
	tst <- read.table(file.path("./cross_validation_samples", testfile) ,header=F,sep="")
	tst <- unlist(tst)

	### Assing 1 to training and 2 to testing individuals
	Phen[-tst,2]<- 1
	Phen[tst,2]<- 2

	### make a new directory per each fold and replications
	dir.create(paste0(counter,"_output",sep=""), showWarnings = FALSE)

	### store phenotyic data, column number 2 is the training (1) and testing (2) information
	save_train <- file.path(paste0(counter,"_output",sep=""),"trainphen.txt")

	write.table(Phen,save_train, quote = FALSE, row.names =F,col.names=F)


}
