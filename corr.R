### This Rscript computes the predictive correlation and mean squred error of prediction
rm(list=ls())
### Read the file contains predicted BV (GEBV) and adjusted phenotypes
pred <- read.table("tmp", header=F)

### column numbers 6 and 7 are EBV/GEBV and adjusted y

Pred_trait1 <- cor(pred[,6],pred[,7]); Pred_trait1
MSE_1 <- mean((pred[,6]-pred[,7])^2); MSE_1


results <- cbind(Pred_trait1,MSE_1)

write.table(results, file="pred_eval.txt",quote=F,row.names=F)

