#!/bin/sh
module load R
### 1. Run Train-test program to partition the individuals for 5-fold cross-validation
Rscript Train_Test.R

### 2. Run Pred_set.R program to assign individuals of phenotype file to reference (Train) and validation (Test) set
Rscript Pred_set.R

### 3. Create error and log files to save the warning and error messages

mkdir -p {logs,errors}

