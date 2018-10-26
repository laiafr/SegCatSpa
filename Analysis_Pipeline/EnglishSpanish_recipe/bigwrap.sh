#!/usr/bin/env bash

# Wrapper to run wordseg experiments - spa & eng version
# Alex Cristia <alecristia@gmail.com> 2017-01-14
# Mathieu Bernard
# Laia Fibla 2017-01-19
# Alex Cristia 2018-10-12

############ VARIABLES ##############
# Adapt this section with your absolute paths and other variables

lang1="eng"
lang2="spa"

ROOT="/scratch1/projects/wordseg-biling/SegCatSpa/"

INPUT_CORPUS="$ROOT/Corpora/cha/" #where you have put the talkbank corpora to be analyzed
PHONO_FOLDER="$ROOT/Corpora/phono/"
CONCATENATED_FOLDER="$ROOT/Corpora/concat/"
SPLIT_FOLDER="$ROOT/Corpora/split/"
RES_FOLDER="$ROOT/Results/"


#if running on oberon, do:
module load anaconda/3
source activate wordseg
#####################################

	# Create Database
	# Turn the cha-like files into a single clean file per type
	# ONLY ENGLISH NEEDS TO BE DONE; the script is the exact same as in exp. 1
./1_selAndClean.sh ${INPUT_CORPUS}/${lang1} ${PHONO_FOLDER}/${lang1}

	# Phonologize
	# turn transcriptions from orthographical to phonological
	# ONLY ENGLISH NEEDS TO BE DONE; the script is the exact same as in exp. 1
./2_phonologize.sh ${lang2}  ${PHONO_FOLDER}${lang2} #requires phonemizer


	# Concatenate the corpora
	# the script is almost identical to the cat-spa version, except that it does NOT generate the lang2_lang2 version (since it already exists), and that it stops whent the lang1_lang1 corpus is of the same size as lang2_lang2
./3_concatenate_l1.sh ${PHONO_FOLDER}/${lang1}  ${PHONO_FOLDER}/${lang2} ${CONCATENATED_FOLDER}


	# The bilingual corpus is double size than the monolinguals, this step divides it in two parts, one called 0 and 1 called 1. 
	# Then we select part zero to be the one that gets analyzed and move part 1 somewhere else where it won't get analyzed
divide_half=2
mv ${CONCATENATED_FOLDER}${lang1}_${lang2}/ ${CONCATENATED_FOLDER}${lang1}_${lang2}_whole/
./4_cut.sh ${CONCATENATED_FOLDER}${lang1}_${lang2}_whole/1 ${CONCATENATED_FOLDER}${lang1}_${lang2}/1 ${divide_half}
./4_cut.sh ${CONCATENATED_FOLDER}${lang1}_${lang2}_whole/100 ${CONCATENATED_FOLDER}${lang1}_${lang2}/100 ${divide_half}

mv ${CONCATENATED_FOLDER}${lang1}_${lang2}/1/1-tags.txt ${CONCATENATED_FOLDER}${lang1}_${lang2}_whole/1/
mv ${CONCATENATED_FOLDER}${lang1}_${lang2}/100/1-tags.txt ${CONCATENATED_FOLDER}${lang1}_${lang2}_whole/100/
mv ${CONCATENATED_FOLDER}${lang1}_${lang2}/1/0-tags.txt ${CONCATENATED_FOLDER}${lang1}_${lang2}/1/tags.txt
mv ${CONCATENATED_FOLDER}${lang1}_${lang2}/100/0-tags.txt ${CONCATENATED_FOLDER}${lang1}_${lang2}/100/tags.txt

	# Divide
	# divide the big corpora in 10 parts to evaluate the robustness of the F-score
	# as before,  ${lang2}_${lang2} is not done (it alread exists
divide_multiple=10

for thispart in ${lang1}_${lang2} ${lang1}_${lang1} ; do
    ./4_cut.sh ${CONCATENATED_FOLDER}/$thispart/100 ${SPLIT_FOLDER}/$thispart/100 ${divide_multiple}
    ./4_cut.sh ${CONCATENATED_FOLDER}/$thispart/1 ${SPLIT_FOLDER}/$thispart/1 ${divide_multiple}
done

	# Analyze
#rm -r ${RES_FOLDER}/*


