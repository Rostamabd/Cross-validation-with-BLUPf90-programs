### This script was written by Rostam Abdollahi at 8/10/2016 to collect multiple analyses results in one file

predcor <- numeric()
predmse <- numeric()

### 5-fold CV and 5 replications (25 analyses)
for(i in 1:25) {
	outfile <- paste(i,"_output/pred_eval.txt",sep="")
	sol <- read.table(outfile ,header=T)
	colnames(sol) <- c("pred","mse")

	predcor[i] <- sol[1,1]

	predmse[i] <- sol[1,2]

}


### store predictive correlations and MSEs

Results <- cbind(predcor, predmse)

colnames(Results) <- c("PredCor", "MSEP")
cat("Means:",colMeans(Results),"\n")

write.table(Results,file="Pred_Results.txt", quote = FALSE)
