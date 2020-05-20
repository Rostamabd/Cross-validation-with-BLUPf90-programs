# Cross-validation with BLUPf90 programs

**Author**: *Rostam Abdollahi-Arpanahi*

**Date**: May 19, 2020

---

BLUPf90 family of programs are well-known collection of softwares for mixed model analysis in animal breeding. In the last decade Misztal group modified programs to conduct the Single Step GBLUP analysis. In genomic prediction, single-step GBLUP has been demonstrated to outperform multi-step GBLUP . However, one of limitation of BLUPf90 family of programs is that user is not able to change the name of output files, in particular for cross-validation (CV) analysis.  In this case, user must create different folders and run each fold of cross validation within specific folder and at the end, collect all the results and report the desired statistics.

In this repository, you can find four key files for running 5-fold CV and 5 replications (25 analysis). 

An example data consisted of phenotype, pedigree and genotype data simulated by QMSim is provided to inspire you for running your own analysis.

## 1. Download data, Rscripts and executable files

```
git clone https://github.com/Rostamabd/Cross-validation-with-BLUPf90-programs.git
```

## 2. Run bash script (**BLUPf90_Cross_Validation.sh**) 

Actually, by running this bash file, two Rscripts namely **<u>Train_Test.R</u>** and **<u>Pred_set.R</u>** and a unix commend for creating two new folders will be executed.  

```
chmod 775 BLUPf90_Cross_Validation.sh
./BLUPf90_Cross_Validation.sh
```

Instead of running **<u>BLUPf90_Cross_Validation.sh</u>**, user can run: 1) **<u>Train_Test.R</u>** for assigning individuals randomly to training and testing set for 5-fold cross validation and 5 replications. It will create a new folder called ***cross_validation_samples*** which includes the animal IDs for training and testing sets. 2) **<u>Pred_set.R</u>** for creating 25 folders and within each folder it will put a phenotypic file with training=1 and testing=2 individuals. 3) using the unix command *mkdir* craete two new folders (errors and logs) for reporting the errors and log files.

```
module load R
Rscript Train_Test.R
Rscript Pred_set.R
mkdir -p {logs,errors}
```

## 3. Run BLUPf90 family programs

The main program for running BLUPf90 family program in parallel is <u>**submit_GBLUP.sbatch**</u>. The bash script is for running a slurm job as parallel on the HiPerGator’s high-performance computation servers located at University of Florida. The format of job submission is as array jobs. User depends on the cluster availability can modify the number of CPUs, memory per each job and etc.

````
sbatch submit_GBLUP.sbatch
````

Depends on the clusters availability and number of nodes within each cluster, 25 jobs can be submitted in parallel. The results of each job will be saved in a folder called *_output. The important file in the output folders is <u>pred_eval.txt</u>. In this file you have predictive correlations and mean-squared error of prediction from each fold of CV.

## 4. Collect the predictive ability results

If you run **Results_Predictive_Ability.R** file, it will collect all the prediction results and save them in a output file called Pred_Results.txt. 

```
module load R
Rscript Results_Predictive_Ability.R
```

## Contact Information

Please send your comments and suggestions to rostam7474 at gmail dot com

