### Partition the population to training and testing set (here 5-fold cross-validation (CV) and 5 replications)
rm(list=ls(all=TRUE))

### Creat a new folder to save  training and testing samples
dir.create("cross_validation_samples", showWarnings = FALSE)

### number of records (modify this according to your data file)
n <- 1755

### number of replications
reps <- 5
### numbers of CV folds
nFolds <- 5

### A counter to write down the combination of fold and replication
counter <- 0
#######Begin

for (i in 1:reps){
	cat("Replication:", i,"\n")

	### assign data to training and testing
	folds <- rep(1:nFolds,(n/nFolds))[order(runif(n))]
	for(fold in 1:nFolds){
		counter= counter+1
		test <- sort(which(folds==fold))
		train <-  sort(which(folds!=fold))


		trainfile <- file.path(".", "cross_validation_samples",paste(counter,"training_samples.data",sep=""))

		testfile <- file.path(".", "cross_validation_samples",paste(counter,"testing_samples.data",sep=""))
 
		write.table(train, file= trainfile  , quote = TRUE, sep = " ",  eol = "\n", row.names = FALSE, col.names = FALSE)
		write.table(test , file=testfile, quote = TRUE, sep = " ",  eol = "\n", row.names = FALSE, col.names = FALSE)
	}
}
