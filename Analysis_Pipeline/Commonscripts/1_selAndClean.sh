#!/bin/sh
# Wrapper written by Alex Cristia to process the orthograpically transcived corpora in .cha
# Modified by Laia Fibla 2017-02-15
# minor alex 2018-10-12

###### Variables #######

# Adapt the following variables, being careful to provide absolute paths
# Here all paths are previously specified in the bigwrap.sh

INPUT_CORPUS=$1 #where you have put the talkbank corpora to be analyzed e.g. INPUT_CORPUS="/fhgfs/bootphon/scratch/lfibla/seg/SegCatSpa/corpus_database/cat_big"
RES_FOLDER=$2 #this is where we will put the processed versions of the transcripts e.g. RES_FOLDER="/fhgfs/bootphon/scratch/lfibla/seg/SegCatSpa/big_corpora/RES_corpus_cat"

########################

INPUT_FILES="${RES_FOLDER}/info.txt" # e.g. INPUT_FILES="/home/xcao/cao/projects/ANR_Alex/res_Childes_Eng-NA_cds/childes_info.txt"

OUTPUT_FILE2="${RES_FOLDER}/processedFiles.txt" #e.g. OUTPUT_FILE2="/home/xcao/cao/projects/ANR_Alex/res_Childes_Eng-NA_cds/processed_files.txt"

mkdir -p $RES_FOLDER	#create folder that will contain all output files
python ../Commonscripts/extract_childes_info.py $INPUT_CORPUS $INPUT_FILES
echo "done extracting info from corpora"


for f in ${INPUT_CORPUS}/*.cha ${INPUT_CORPUS}/*/*.cha ${INPUT_CORPUS}/*/*/*.cha; do	#loop through all cha files

echo "finding out who's a speaker in $f"

	    IncludedParts=`tr '\015' '\n' < $f | #for each file
#		iconv -f ISO-8859-1 | #convert the file to deal with multibyte e.g. accented characters ###!!! try -t -- this is not working
		grep "@ID" |      #take only @ID lines of the file
		awk -F "|" '{ print $3, $8 }' | #let through only 3-letter code and role
        grep -v 'Target_Child\|Child\|Sister\|Brother\|Cousin\|Boy\|Girl\|Unidentified\|Sibling\|Target\|Nurse\|Investigator\|Experimentator\|Non_Hum\|Play' | #remove all the children and non-human participants to leave only adults
        awk '{ print $1 }' | #print out the first item, which is the 3 letter code for those adults
		tr "\n" "%" | # put them all in the same line
		sed "s/^/*/g" | #add an asterisk at the beginning
		sed "s/%/\\\\\|*/g" | #add a pipe between every two
		sed "s/\\\\\|.$//" ` #remove the pipe* next to the end of line & close the text call

		name=`echo $f | sed "s|$INPUT_CORPUS||g" | tr "/" "_" `
		SELFILE=$(basename "$name" .cha)"-includedlines.txt"

		if [ -z "$IncludedParts" ] ; then
      			echo "no good participants"
		else

		    bash ../Commonscripts/cha2sel_withinputParticipants.sh $f ${RES_FOLDER}/${SELFILE} $IncludedParts

		    nlines=`wc -l ${RES_FOLDER}/${SELFILE} | awk '{print $1}' `

		    if [ $nlines -gt 99 ] ; then
	 		ORTHO=$(basename "$name" .cha)"-ortholines.txt"
			bash ../Commonscripts/selcha2clean.sh ${RES_FOLDER}/${SELFILE} ${RES_FOLDER}/$ORTHO

			echo "processed $f" >> $OUTPUT_FILE2
		    fi

		fi

done

echo "done creating included and ortholines"

rm $RES_FOLDER/*.txt-e #phantom files created
rm $RES_FOLDER/_\*-*.txt #more weird files created
rm $RES_FOLDER/-*
find . -type d -empty -delete #remove empty folders for non-processed corpora
echo "done cleaning"

echo "files in ${RES_FOLDER}"
