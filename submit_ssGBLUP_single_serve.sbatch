#!/bin/sh

for i in {1..25}
do

pwd; hostname; date

RUN=$i

cp para.par corr.R  predictf90 postGSf90 blupf90 renumf90 predf90 preGSf90 ./$RUN"_output"/
cd $RUN"_output"
chmod 775 predictf90
chmod 775 postGSf90
chmod 775 blupf90
chmod 775 renumf90
chmod 775  predf90
chmod 775 preGSf90


module load R

# Run renf90
        echo para.par | ./renumf90 | tee ren.log 


#Run ssBLUP using blupf90 and do the prediction for all individuals

        echo renf90.par | ./blupf90 | tee ssblup.log
	echo OPTION include_effects 1 >> renf90.par
        echo renf90.par | ./predictf90 > all_data.log


#Validation data set for prediction
        awk '$3!=2' renf90.dat > renf90.dat.pred
	sed -i 's/OPTION include_effects 1/#OPTION include_effects 1/g' renf90.par
        sed 's/renf90.dat/renf90.dat.pred/g' renf90.par > validationSSBLUP.par


# Run ssGBLUP for only training set, ignore phenotypic data of validation set
        echo validationSSBLUP.par | ./blupf90 |tee validationSSBLUP.log

# Prepare the Results for chiching the predictive ability using ssBLUP
	awk '{ print $1,$2}' yhat_residual | sort -k 1,1 -g > yhat
	awk '{if ($2==1) print $3,$4}' solutions | sort -k 1,1 -g > ebv.temp
	join -1 +1 -2 +1 yhat ebv.temp > file.temp
        awk '{print $1,$10,$6}' renadd01.ped | sort -k 1,1 -g  > ped.sort
	join -1 +1 -2 +1  ped.sort file.temp > id.bv        

# Extract Animal IDs, test and train set, phenotype
        awk '{ print $2,$3,$1}' renf90.dat | sort -k 1,1 -g > test_train.txt
        join -1 +1 -2 +1 test_train.txt id.bv > final_results

# Using R report the predictive ability for validation set and goodness of fit for training set
        awk '$5>=10 && $2==2' final_results > tmp
        echo ''
        echo Predictive Correlation for Genotyped Animals in the testing set
        Rscript corr.R
cd ../

done

echo "all done"

