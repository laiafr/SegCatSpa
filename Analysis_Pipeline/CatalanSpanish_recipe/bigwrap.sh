#!/usr/bin/env bash

# Wrapper to run wordseg experiments - cat & spa version
# Alex Cristia <alecristia@gmail.com> 2017-01-14
# Mathieu Bernard
# Laia Fibla 2017-01-19
# Alex Cristia 2018-10-12
# Alex 2020-02-03 add ana of whole biling
# Alex 2021-01-21 add separate train and test

################# Variables ##############
# Adapt this section with your absolute paths and other variables

lang1="spa"
lang2="cat"

ROOT="/scratch1/projects/wordseg-biling/SegCatSpa/"
#ROOT="~/Dropbox/SegCatSpa/"

INPUT_CORPUS="$ROOT/Corpora/cha/" #where you have put the talkbank corpora to be analyzed
PHONO_FOLDER="$ROOT/Corpora/phono/"
CONCATENATED_FOLDER="$ROOT/Corpora/concat/${lang1}_${lang2}_match/"
TRAIN_FOLDER="$ROOT/Corpora/concat/${lang1}_${lang2}_match_80pc/"
TEST_FOLDER="$ROOT/Corpora/concat/${lang1}_${lang2}_match_20pc/"
SPLIT_FOLDER="$ROOT/Corpora/split/${lang1}_${lang2}_match/"
RES_FOLDER="$ROOT/Results/${lang1}_${lang2}_match/"


#if running on oberon, do:
module load anaconda/3
source activate wordseg


#########################################

	# Create Database
	# Turn the cha-like files into a single clean file per type
#./../Commonscripts/1_selAndClean.sh ${INPUT_CORPUS}/${lang1} ${PHONO_FOLDER}/${lang1}
#./../Commonscripts/1_selAndClean.sh ${INPUT_CORPUS}/${lang2} ${PHONO_FOLDER}/${lang2}

	# Phonologize
	# turn transcriptions from orthographical to phonological
#./../Commonscripts/2_phonologize.sh ${lang1}  ${PHONO_FOLDER}${lang1} #does not require phonemizer
#./../Commonscripts/2_phonologize.sh ${lang2}  ${PHONO_FOLDER}${lang2} #does require phonemizer

	# Concatenate the corpora
#./3_concatenate.sh ${PHONO_FOLDER}/${lang1}  ${PHONO_FOLDER}/${lang2} ${CONCATENATED_FOLDER}

	# The bilingual corpus is double size than the monolinguals, this step divides it in two parts, one called 0 and 1 called 1. 
	# Then we select part zero to be the one that gets analyzed and move part 1 somewhere else where it won't get analyzed
#divide_half=2
#rm -r ${CONCATENATED_FOLDER}${lang1}_${lang2}_whole/
#mv ${CONCATENATED_FOLDER}${lang1}_${lang2}/ ${CONCATENATED_FOLDER}${lang1}_${lang2}_whole/
#./../Commonscripts/4_cut.sh ${CONCATENATED_FOLDER}${lang1}_${lang2}_whole/1 ${CONCATENATED_FOLDER}${lang1}_${lang2}/1 ${divide_half}
#./../Commonscripts/4_cut.sh ${CONCATENATED_FOLDER}${lang1}_${lang2}_whole/100 ${CONCATENATED_FOLDER}${lang1}_${lang2}/100 ${divide_half}


#mv ${CONCATENATED_FOLDER}${lang1}_${lang2}/1/1-tags.txt ${CONCATENATED_FOLDER}${lang1}_${lang2}_whole/1/.
#mv ${CONCATENATED_FOLDER}${lang1}_${lang2}/100/1-tags.txt ${CONCATENATED_FOLDER}${lang1}_${lang2}_whole/100/.
#mv ${CONCATENATED_FOLDER}${lang1}_${lang2}/1/0-tags.txt ${CONCATENATED_FOLDER}${lang1}_${lang2}/1/tags.txt
#mv ${CONCATENATED_FOLDER}${lang1}_${lang2}/100/0-tags.txt ${CONCATENATED_FOLDER}${lang1}_${lang2}/100/tags.txt

	# Divide
	# divide the big corpora in 10 parts to evaluate the robustness of the F-score
#divide_multiple=10

#for thispart in ${lang1}_${lang2} ${lang1}_${lang1} ${lang2}_${lang2} ; do
#    ./../Commonscripts/4_cut.sh ${CONCATENATED_FOLDER}/$thispart/100 ${SPLIT_FOLDER}/$thispart/100 ${divide_multiple}
#    ./../Commonscripts/4_cut.sh ${CONCATENATED_FOLDER}/$thispart/1 ${SPLIT_FOLDER}/$thispart/1 ${divide_multiple}
#done

	# Analyze

	#analyze the folders prior to the split
#./../Commonscripts/5_analyze.sh ${CONCATENATED_FOLDER}${lang1}_${lang1}/100 ${RES_FOLDER}/${lang1}_${lang1}/100
#./../Commonscripts/5_analyze.sh ${CONCATENATED_FOLDER}${lang1}_${lang1}/1 ${RES_FOLDER}/${lang1}_${lang1}/1

#./../Commonscripts/5_analyze.sh ${CONCATENATED_FOLDER}${lang2}_${lang2}/100 ${RES_FOLDER}/${lang2}_${lang2}/100
#./../Commonscripts/5_analyze.sh ${CONCATENATED_FOLDER}${lang2}_${lang2}/1 ${RES_FOLDER}/${lang2}_${lang2}/1

#./../Commonscripts/5_analyze.sh ${CONCATENATED_FOLDER}${lang1}_${lang2}/100 ${RES_FOLDER}/${lang1}_${lang2}/100
#./../Commonscripts/5_analyze.sh ${CONCATENATED_FOLDER}${lang1}_${lang2}/1 ${RES_FOLDER}/${lang1}_${lang2}/1


	#analyze the splits
#./../Commonscripts/5_analyze.sh ${SPLIT_FOLDER}${lang1}_${lang1}/100 ${RES_FOLDER}/${lang1}_${lang1}/100_split
#./../Commonscripts/5_analyze.sh ${SPLIT_FOLDER}${lang1}_${lang1}/1 ${RES_FOLDER}/${lang1}_${lang1}/1_split

#./../Commonscripts/5_analyze.sh ${SPLIT_FOLDER}${lang2}_${lang2}/100 ${RES_FOLDER}/${lang2}_${lang2}/100_split
#./../Commonscripts/5_analyze.sh ${SPLIT_FOLDER}${lang2}_${lang2}/1 ${RES_FOLDER}/${lang2}_${lang2}/1_split

#./../Commonscripts/5_analyze.sh ${SPLIT_FOLDER}${lang1}_${lang2}/100 ${RES_FOLDER}/${lang1}_${lang2}/100_split
#./../Commonscripts/5_analyze.sh ${SPLIT_FOLDER}${lang1}_${lang2}/1 ${RES_FOLDER}/${lang1}_${lang2}/1_split

# ADDED 2020-02-03 analyze the whole biling
#./../Commonscripts/5_analyze.sh ${CONCATENATED_FOLDER}${lang1}_${lang2}_whole/1 ${RES_FOLDER}/${lang1}_${lang2}/1_whole

# ADDED 2021-01-21 train on 80% and test on 20%
#mkdir -p ${TRAIN_FOLDER}${lang1}_${lang1}/100
#mkdir -p ${TRAIN_FOLDER}${lang2}_${lang2}/100
#mkdir -p ${TRAIN_FOLDER}${lang1}_${lang2}/100
#mkdir -p ${TEST_FOLDER}${lang1}_${lang1}/100
#mkdir -p ${TEST_FOLDER}${lang2}_${lang2}/100
#mkdir -p ${TEST_FOLDER}${lang1}_${lang2}/100

# first do the train/test split
#for j in ${CONCATENATED_FOLDER}${lang1}_${lang1}/100/*.txt; do 
#    csplit $j $(( $(wc -l < $j ) * 8 / 10 + 1))  
#    k="$(basename -- $j)"  
#    mv xx00 ${TRAIN_FOLDER}${lang1}_${lang1}/100/$k 
#    mv xx01 ${TEST_FOLDER}${lang1}_${lang1}/100/$k 
#done

#for j in ${CONCATENATED_FOLDER}${lang2}_${lang2}/100/*.txt; do 
#    csplit $j $(( $(wc -l < $j ) * 8 / 10 + 1))  
#    k="$(basename -- $j)"  
#    mv xx00 ${TRAIN_FOLDER}${lang2}_${lang2}/100/$k 
#    mv xx01 ${TEST_FOLDER}${lang2}_${lang2}/100/$k 
#done

#for j in ${CONCATENATED_FOLDER}${lang1}_${lang2}/100/*.txt; do 
#    csplit $j $(( $(wc -l < $j ) * 8 / 10 + 1)) 
#    k="$(basename -- $j)"  
#    mv xx00 ${TRAIN_FOLDER}${lang1}_${lang2}/100/$k 
#    mv xx01 ${TEST_FOLDER}${lang1}_${lang2}/100/$k 
#done

# Launch analyses with separate train/test
#./../Commonscripts/5_analyze_tt.sh ${TRAIN_FOLDER}${lang1}_${lang1}/100 ${TEST_FOLDER}${lang1}_${lang1}/100 ${RES_FOLDER}/${lang1}_${lang1}/100_tt
#./../Commonscripts/5_analyze_tt.sh ${TRAIN_FOLDER}${lang2}_${lang2}/100 ${TEST_FOLDER}${lang2}_${lang2}/100 ${RES_FOLDER}/${lang2}_${lang2}/100_tt
#./../Commonscripts/5_analyze_tt.sh ${TRAIN_FOLDER}${lang1}_${lang2}/100 ${TEST_FOLDER}${lang1}_${lang2}/100 ${RES_FOLDER}/${lang1}_${lang2}/100_tt

#### NOW REPEAT but switching every sentence

#mkdir -p ${TRAIN_FOLDER}${lang1}_${lang1}/1
#mkdir -p ${TRAIN_FOLDER}${lang2}_${lang2}/1
#mkdir -p ${TRAIN_FOLDER}${lang1}_${lang2}/1
#mkdir -p ${TEST_FOLDER}${lang1}_${lang1}/1
#mkdir -p ${TEST_FOLDER}${lang2}_${lang2}/1
#mkdir -p ${TEST_FOLDER}${lang1}_${lang2}/1

# first do the train/test split
#for j in ${CONCATENATED_FOLDER}${lang1}_${lang1}/1/*.txt; do 
#    csplit $j $(( $(wc -l < $j ) * 8 / 10 + 1))  
#    k="$(basename -- $j)"  
#    mv xx00 ${TRAIN_FOLDER}${lang1}_${lang1}/1/$k 
#    mv xx01 ${TEST_FOLDER}${lang1}_${lang1}/1/$k 
#done

#for j in ${CONCATENATED_FOLDER}${lang2}_${lang2}/1/*.txt; do 
#    csplit $j $(( $(wc -l < $j ) * 8 / 10 + 1))  
#    k="$(basename -- $j)"  
#    mv xx00 ${TRAIN_FOLDER}${lang2}_${lang2}/1/$k 
#    mv xx01 ${TEST_FOLDER}${lang2}_${lang2}/1/$k 
#done

#for j in ${CONCATENATED_FOLDER}${lang1}_${lang2}/1/*.txt; do 
#    csplit $j $(( $(wc -l < $j ) * 8 / 10 + 1)) 
#    k="$(basename -- $j)"  
#    mv xx00 ${TRAIN_FOLDER}${lang1}_${lang2}/1/$k 
#    mv xx01 ${TEST_FOLDER}${lang1}_${lang2}/1/$k 
#done

# Launch analyses with separate train/test
./../Commonscripts/5_analyze_tt.sh ${TRAIN_FOLDER}${lang1}_${lang1}/1 ${TEST_FOLDER}${lang1}_${lang1}/1 ${RES_FOLDER}/${lang1}_${lang1}/1_tt_ag
#./../Commonscripts/5_analyze_tt.sh ${TRAIN_FOLDER}${lang1}_${lang1}/1 ${TEST_FOLDER}${lang1}_${lang1}/1 ${RES_FOLDER}/${lang1}_${lang1}/1_tt
#./../Commonscripts/5_analyze_tt.sh ${TRAIN_FOLDER}${lang2}_${lang2}/1 ${TEST_FOLDER}${lang2}_${lang2}/1 ${RES_FOLDER}/${lang2}_${lang2}/1_tt
./../Commonscripts/5_analyze_tt.sh ${TRAIN_FOLDER}${lang1}_${lang2}/1 ${TEST_FOLDER}${lang1}_${lang2}/1 ${RES_FOLDER}/${lang1}_${lang2}/1_tt_ag

	# More analysis on the corpus
#./../Commonscripts/6_compare_languages.sh ${CONCATENATED_FOLDER}${lang1}_${lang1} ${CONCATENATED_FOLDER}${lang2}_${lang2} ${RES_FOLDER}/${lang1}_${lang2}

