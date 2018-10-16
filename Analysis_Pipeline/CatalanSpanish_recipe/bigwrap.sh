#!/usr/bin/env bash

# Wrapper to run WinnipegLENA experiments 201511
# Alex Cristia <alecristia@gmail.com> 2017-01-14
# Mathieu Bernard
# Laia Fibla 2017-01-19
# Alex Cristia 2018-10-12

################# Variables ##############
# Adapt this section with your absolute paths

# Create database and Phonologize
INPUT_CORPUS="/Users/alejandrinacristia/Dropbox/SegCatSpa/Corpora/cha/" #where you have put the talkbank corpora to be analyzed
PATH_TO_SCRIPTS_2="/fhgfs/bootphon/scratch/lfibla/CDSwordSeg/phonologization" #path to the phonologization folder

# Process transcriptions
PROCESSED_FOLDER="/Users/alejandrinacristia/Dropbox/SegCatSpa/Corpora/phono/"
CONCATENATED_FOLDER="/Users/alejandrinacristia/Dropbox/SegCatSpa/Corpora/concat/"
RES_FOLDER="/Users/alejandrinacristia/Dropbox/SegCatSpa/results/"

#########################################

# Create Database
# Turn the cha-like files into a single clean file per type
#./1_selAndClean.sh ${INPUT_CORPUS}/spa ${PROCESSED_FOLDER}/spa
#./1_selAndClean.sh $PATH_TO_SCRIPTS_1 ${INPUT_CORPUS}/cat ${PROCESSED_FOLDER}/cat

# Phonologize
# turn transcriptions from orthographical to phonological
# Select language; language options: cspanish (castillan spanish), catalan  -- NOTICE, IN SMALL CAPS

#if running on oberon, do:
#module load python-anaconda
#source activate phonemizer
#module load espeak


#./2_phonologize.sh cspanish  ${PROCESSED_FOLDER}spa #does not require phonemize
./2_phonologize.sh catalan  ${PROCESSED_FOLDER}cat #NEEDS TESTING

# Concatenate the corpora
#./3_concatenate.sh ${PROCESSED_FOLDER}/spa  ${PROCESSED_FOLDER}/cat ${CONCATENATED_FOLDER}

# The bilingual copora is double size than the monolinguals, this step divides it in two parts
divide_half=2
#./4_cut.sh ${CONCATENATED_FOLDER}spa_cat/4 ${CONCATENATED_FOLDER}spa_cat_h/1 ${divide_half}
#./4_cut.sh ${CONCATENATED_FOLDER}spa_cat/100 ${CONCATENATED_FOLDER}spa_cat_h/100 ${divide_half}

# Divide
# note: this step is just used with big corpora!
# divide the big corpora in 10 parts to evaluate the robustness of the F-score
divide_multiple=10
#./4_cut.sh ${CONCATENATED_FOLDER}spa/100 ${CONCATENATED_FOLDER}spa_10/100 ${divide_multiple}
#./4_cut.sh ${CONCATENATED_FOLDER}spa/4 ${CONCATENATED_FOLDER}spa_10/4 ${divide_multiple}
#./4_cut.sh ${CONCATENATED_FOLDER}cat/100 ${CONCATENATED_FOLDER}cat_10/100 ${divide_multiple}
#./4_cut.sh ${CONCATENATED_FOLDER}cat/4 ${CONCATENATED_FOLDER}cat_10/4 ${divide_multiple}
#./4_cut.sh ${CONCATENATED_FOLDER}spa_cat_h/4/0 ${CONCATENATED_FOLDER}spa_cat_h_10/4 ${divide_multiple}
#./4_cut.sh ${CONCATENATED_FOLDER}spa_cat_h/100/0 ${CONCATENATED_FOLDER}spa_cat_h_10/100 ${divide_multiple}

# Analyze
#rm -r ${RES_FOLDER}spa_10/4/*
#rm -r ${RES_FOLDER}cat_10/4/*
#rm -r ${RES_FOLDER}bil_half_10/4/*
#./5_analyze.sh ${CONCATENATED_FOLDER}spa ${RES_FOLDER}spa
#./5_analyze.sh ${CONCATENATED_FOLDER}cat ${RES_FOLDER}cat
#./5_analyze.sh ${CONCATENATED_FOLDER}bil ${RES_FOLDER}bil_all

#./5_analyze.sh ${CONCATENATED_FOLDER}spa_10/100 ${RES_FOLDER}spa_10/100
#./5_analyze.sh ${CONCATENATED_FOLDER}spa_10/4 ${RES_FOLDER}spa_10/4
#./5_analyze.sh ${CONCATENATED_FOLDER}cat_10/100 ${RES_FOLDER}cat_10/100
#./5_analyze.sh ${CONCATENATED_FOLDER}cat_10/4 ${RES_FOLDER}cat_10/4

#./5_analyze.sh ${CONCATENATED_FOLDER}bil_half_10/100 ${RES_FOLDER}bil_half_10/100
#./5_analyze.sh ${CONCATENATED_FOLDER}bil_half_10/4 ${RES_FOLDER}bil_half_10/4
#echo ${RES_FOLDER}

# Collapse results
#rm ${RES_FOLDER}spa/results.txt
#rm ${RES_FOLDER}cat/results.txt
#rm ${RES_FOLDER}bil/results.txt
#rm ${RES_FOLDER}bil_all/results.txt
#rm ${RES_FOLDER}spa_10/100/results.txt
#rm ${RES_FOLDER}spa_10/4/results.txt
#rm ${RES_FOLDER}cat_10/100/results.txt
#rm ${RES_FOLDER}cat_10/4/results.txt
#rm ${RES_FOLDER}bil_half_10/4/results.txt
#rm ${RES_FOLDER}bil_half_10/100/results.txt
#./6_collapse_results.sh ${RES_FOLDER}spa/
#./6_collapse_results.sh ${RES_FOLDER}spa_10/100
#./6_collapse_results.sh ${RES_FOLDER}spa_10/4
#./6_collapse_results.sh ${RES_FOLDER}cat/
#./6_collapse_results.sh ${RES_FOLDER}cat_10/100
#./6_collapse_results.sh ${RES_FOLDER}cat_10/4
#./6_collapse_results.sh ${RES_FOLDER}bil
#./6_collapse_results.sh ${RES_FOLDER}bil_half_10/4
#echo "done collapsing results"

# More analysis on the coprus
#./_describe_gold.sh
#./_compare_languages.sh
