#!/usr/bin/env bash

# Wrapper to run WinnipegLENA experiments 201511
# Alex Cristia <alecristia@gmail.com> 2017-01-14
# Mathieu Bernard
# Laia Fibla 2017-01-19
# Alex Cristia 2018-10-12

################# Variables ##############
# Adapt this section with your absolute paths and other variables

lang1="spa"
lang2="cat"

# Create database and Phonologize
INPUT_CORPUS="/Users/alejandrinacristia/Dropbox/SegCatSpa/Corpora/cha/" #where you have put the talkbank corpora to be analyzed
PATH_TO_SCRIPTS_2="/fhgfs/bootphon/scratch/lfibla/CDSwordSeg/phonologization" #path to the phonologization folder

# Process transcriptions
PHONO_FOLDER="/Users/alejandrinacristia/Dropbox/SegCatSpa/Corpora/phono/"
CONCATENATED_FOLDER="/Users/alejandrinacristia/Dropbox/SegCatSpa/Corpora/concat/"
SPLIT_FOLDER="/Users/alejandrinacristia/Dropbox/SegCatSpa/Corpora/split/"
RES_FOLDER="/Users/alejandrinacristia/Dropbox/SegCatSpa/results/"

#########################################

# Create Database
# Turn the cha-like files into a single clean file per type
#./1_selAndClean.sh ${INPUT_CORPUS}/${lang1} ${PHONO_FOLDER}/${lang1}
#./1_selAndClean.sh ${INPUT_CORPUS}/${lang2} ${PHONO_FOLDER}/${lang2}

# Phonologize
# turn transcriptions from orthographical to phonological

#if running on oberon, do:
#module load python-anaconda
#source activate phonemizer
#module load espeak


#./2_phonologize.sh ${lang1}  ${PHONO_FOLDER}${lang1} #does not require phonemizer
#./2_phonologize.sh ${lang2}  ${PHONO_FOLDER}${lang2} #does require phonemizer

# Concatenate the corpora
#./3_concatenate.sh ${PHONO_FOLDER}/${lang1}  ${PHONO_FOLDER}/${lang2} ${CONCATENATED_FOLDER}

# The bilingual copora is double size than the monolinguals, this step divides it in two parts, one called 0 and 1 called 1. Then we randomly select part zero to be the one that gets analyzed
divide_half=2
#mv ${CONCATENATED_FOLDER}${lang1}_${lang2}/ ${CONCATENATED_FOLDER}${lang1}_${lang2}_whole/
#./4_cut.sh ${CONCATENATED_FOLDER}${lang1}_${lang2}_whole/1 ${CONCATENATED_FOLDER}${lang1}_${lang2}/1 ${divide_half}
#./4_cut.sh ${CONCATENATED_FOLDER}${lang1}_${lang2}_whole/100 ${CONCATENATED_FOLDER}${lang1}_${lang2}/100 ${divide_half}

#mv ${CONCATENATED_FOLDER}${lang1}_${lang2}/1/0/* ${CONCATENATED_FOLDER}${lang1}_${lang2}/1/
#mv ${CONCATENATED_FOLDER}${lang1}_${lang2}/100/0/* ${CONCATENATED_FOLDER}${lang1}_${lang2}/100/

# Divide
# divide the big corpora in 10 parts to evaluate the robustness of the F-score
divide_multiple=10

#for l1 in $lang1 $lang2 ; do
#   for l2 in $lang1 $lang2 ; do
#	./4_cut.sh ${CONCATENATED_FOLDER}${l1}_${l2}/100 ${SPLIT_FOLDER}${l1}_${l2}/100 ${divide_multiple}
#	./4_cut.sh ${CONCATENATED_FOLDER}${l1}_${l2}/1 ${SPLIT_FOLDER}${l1}_${l2}/1 ${divide_multiple}
#   done
#done

rm -r ${SPLIT_FOLDER}${l2}_${l1}

# Analyze
#rm -r ${RES_FOLDER}/*

#./5_analyze.sh ${CONCATENATED_FOLDER}${lang1} ${RES_FOLDER}${lang1}
#./5_analyze.sh ${CONCATENATED_FOLDER}${lang2} ${RES_FOLDER}${lang2}
#./5_analyze.sh ${CONCATENATED_FOLDER}bil ${RES_FOLDER}bil_all

#./5_analyze.sh ${CONCATENATED_FOLDER}${lang1}_10/100 ${RES_FOLDER}${lang1}_10/100
#./5_analyze.sh ${CONCATENATED_FOLDER}${lang1}_10/4 ${RES_FOLDER}${lang1}_10/4
#./5_analyze.sh ${CONCATENATED_FOLDER}${lang2}_10/100 ${RES_FOLDER}${lang2}_10/100
#./5_analyze.sh ${CONCATENATED_FOLDER}${lang2}_10/4 ${RES_FOLDER}${lang2}_10/4

#./5_analyze.sh ${CONCATENATED_FOLDER}bil_half_10/100 ${RES_FOLDER}bil_half_10/100
#./5_analyze.sh ${CONCATENATED_FOLDER}bil_half_10/4 ${RES_FOLDER}bil_half_10/4
#echo ${RES_FOLDER}

# Collapse results
#rm ${RES_FOLDER}${lang1}/results.txt
#rm ${RES_FOLDER}${lang2}/results.txt
#rm ${RES_FOLDER}bil/results.txt
#rm ${RES_FOLDER}bil_all/results.txt
#rm ${RES_FOLDER}${lang1}_10/100/results.txt
#rm ${RES_FOLDER}${lang1}_10/4/results.txt
#rm ${RES_FOLDER}${lang2}_10/100/results.txt
#rm ${RES_FOLDER}${lang2}_10/4/results.txt
#rm ${RES_FOLDER}bil_half_10/4/results.txt
#rm ${RES_FOLDER}bil_half_10/100/results.txt
#./6_collapse_results.sh ${RES_FOLDER}${lang1}/
#./6_collapse_results.sh ${RES_FOLDER}${lang1}_10/100
#./6_collapse_results.sh ${RES_FOLDER}${lang1}_10/4
#./6_collapse_results.sh ${RES_FOLDER}${lang2}/
#./6_collapse_results.sh ${RES_FOLDER}${lang2}_10/100
#./6_collapse_results.sh ${RES_FOLDER}${lang2}_10/4
#./6_collapse_results.sh ${RES_FOLDER}bil
#./6_collapse_results.sh ${RES_FOLDER}bil_half_10/4
#echo "done collapsing results"

# More analysis on the coprus
#./_describe_gold.sh
#./_compare_languages.sh
