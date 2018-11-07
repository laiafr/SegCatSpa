#!/bin/sh
# Script to concatenate various transcripts into monolingual and bilingual versions, 
# alternating every 4 and 100 lines.
# Laia Fibla and Alex Cristia laia.fibla.reixachs@gmail.com 2017-01-10
# Major edits Alex Cristia 2018-09-26

###### Variables #######

# Adapt the following variables, being careful to provide absolute paths

#lang1="/Users/alejandrinacristia/gitrepos/SegCatSpa/Catalan_Spanish/big_corpora/cat"
#lang2="/Users/alejandrinacristia/gitrepos/SegCatSpa/Catalan_Spanish/big_corpora/spa"
#output="/Users/alejandrinacristia/gitrepos/SegCatSpa/Catalan_Spanish/big_corpora/"

lang1=$1
lang2=$2
output=$3
ref_file=$4

echo  $lang1 $lang2 $output #just to check

########################
lang1_name=`echo $lang1 | sed "s/.*\///"`
lang2_name=`echo $lang2 | sed "s/.*\///"`

rm ${lang1}/*tags.txt.cut ${lang2}/*tags.txt.cut

# exclude lines that do not lead to a multiple of 100
for s in ${lang1}/*tags.txt ${lang2}/*tags.txt
do
echo $s
   max=`wc -l $s | grep -v "total" | awk '{print $1}'`
   if [ $max -gt 100 ] ; then
        n=$(( ($max / 100)*100 ))
#echo cutting $s
        head -$n $s > ${s}.cut
   fi
done

# cleaning, in case you re-run this script
rm ${lang1_name}.txt 
rm ${lang2_name}.txt
rm ${output}/${lang1_name}_*/*/tags.txt
mkdir -p ${output}/${lang1_name}_${lang1_name}/100/
mkdir -p ${output}/${lang1_name}_${lang1_name}/1/
mkdir -p ${output}/${lang1_name}_${lang2_name}/100/
mkdir -p ${output}/${lang1_name}_${lang2_name}/1/

#list the files that go into the two types
ls ${lang1}/*tags.txt.cut > ${lang1_name}.txt   # eg list catalan transcripts
ls ${lang2}/*tags.txt.cut > ${lang2_name}.txt   # eg list cspanish transcripts

#get the number of files in each list
n1files=`wc -l ${lang1_name}.txt | awk '{print $1}' `
n2files=`wc -l ${lang2_name}.txt | awk '{print $1}' `

#get N of lines in each lang
max1=`wc -l $(cat ${lang1_name}.txt) | grep "total" | awk '{print $1}' `
max2=`wc -l $ref_file | awk '{print $1}' `   # CRUCIAL DIFFERENCE HERE WRT SIMPLE CONCATENATE!!! THE MAX IS GIVEN BY THE EXTANT LANG2-LANG2 FILE

end=100

#while there are some files to go through AND we have not attained the line max
while [ "$n1files" -gt 2 -a "$n2files" -gt 2 -a "$end" -lt "$max1" -a "$end" -lt "$max2" ] ; do

#for language 1
  #get the files that are top of the list
	selfile1_lang1=`head -1 ${lang1_name}.txt | awk '{print $1}'`
	selfile2_lang1=`head -2 ${lang1_name}.txt | tail -1 | awk '{print $1}'`

#repeat the process for language 2
	selfile1_lang2=`head -1 ${lang2_name}.txt | awk '{print $1}'`
	selfile2_lang2=`head -2 ${lang2_name}.txt | tail -1 | awk '{print $1}'`


#send the first 100 lines of each file for each language to each of the 2 piles, for the 100 condition, and repeat 100 times for the switching every line condition
   #100 lines blocks
	#mono1
         sed -n 1,100p $selfile1_lang1 >> ${output}/${lang1_name}_${lang1_name}/100/tags.txt
         sed -n 1,100p $selfile2_lang1 >> ${output}/${lang1_name}_${lang1_name}/100/tags.txt
	#bi
         sed -n 1,100p $selfile1_lang1 >> ${output}/${lang1_name}_${lang2_name}/100/tags.txt
         sed -n 1,100p $selfile1_lang2 >> ${output}/${lang1_name}_${lang2_name}/100/tags.txt
         sed -n 1,100p $selfile2_lang1 >> ${output}/${lang1_name}_${lang2_name}/100/tags.txt
         sed -n 1,100p $selfile2_lang2 >> ${output}/${lang1_name}_${lang2_name}/100/tags.txt
   #switch every line
	for i in `seq 1 100`; do
#echo in the single line switch $i

	#mono1
         	sed -n $i,${i}p $selfile1_lang1 >> ${output}/${lang1_name}_${lang1_name}/1/tags.txt
         	sed -n $i,${i}p $selfile2_lang1 >> ${output}/${lang1_name}_${lang1_name}/1/tags.txt
	#bi
        	 sed -n $i,${i}p $selfile1_lang1 >> ${output}/${lang1_name}_${lang2_name}/1/tags.txt
        	 sed -n $i,${i}p $selfile1_lang2 >> ${output}/${lang1_name}_${lang2_name}/1/tags.txt
        	 sed -n $i,${i}p $selfile2_lang1 >> ${output}/${lang1_name}_${lang2_name}/1/tags.txt
        	 sed -n $i,${i}p $selfile2_lang2 >> ${output}/${lang1_name}_${lang2_name}/1/tags.txt
	done

echo this is the number of lines for ${lang1_name}_${lang1_name}
wc -l ${output}/${lang1_name}_${lang1_name}/1/tags.txt


	#and remove the top 100 lines from those 4 files

	tail -n +101 $selfile1_lang1 > temp.txt
	mv temp.txt $selfile1_lang1
#wc -l $selfile1_lang1
	tail -n +101 $selfile2_lang1 > temp.txt
	mv temp.txt $selfile2_lang1
#wc -l $selfile2_lang1
	tail -n +101 $selfile1_lang2 > temp.txt
	mv temp.txt $selfile1_lang2
#wc -l $selfile1_lang2
	tail -n +101 $selfile2_lang2 > temp.txt
	mv temp.txt $selfile2_lang2
#wc -l $selfile2_lang2

  #find out how many lines each file now has, and remove the file name altogether if lower than 100
	selfile1_lang1_lines=`wc -l $selfile1_lang1 | grep -v "total" | awk '{print $1}'`
	selfile2_lang1_lines=`wc -l $selfile2_lang1 | grep -v "total" | awk '{print $1}'`
#echo $selfile1_lang1_lines $selfile2_lang1_lines
	if [ $selfile1_lang1_lines -lt 100 ] ; then
#echo removing $selfile1_lang1
		grep -v "$selfile1_lang1" "${lang1_name}.txt" > temp.txt
		mv temp.txt "${lang1_name}.txt"
	fi
	if [ $selfile2_lang1_lines -lt 100 ] ; then
#echo removing $selfile2_lang1
		grep -v "$selfile2_lang1" "${lang1_name}.txt" > temp.txt
		mv temp.txt  "${lang1_name}.txt"
	fi

#repeat for lang2
	selfile1_lang2_lines=`wc -l $selfile1_lang2 | grep -v "total" | awk '{print $1}'`
	selfile2_lang2_lines=`wc -l $selfile2_lang2 | grep -v "total" | awk '{print $1}'`
#echo $selfile1_lang2_lines $selfile2_lang2_lines
	if [ $selfile1_lang2_lines -lt 100 ] ; then
#echo removing $selfile1_lang2
		grep -v "$selfile1_lang2" "${lang2_name}.txt" > temp.txt
		mv temp.txt "${lang2_name}.txt"
	fi
	if [ $selfile2_lang2_lines -lt 100 ] ; then
#echo removing $selfile2_lang2
		grep -v "$selfile2_lang2" "${lang2_name}.txt" > temp.txt
		mv temp.txt "${lang2_name}.txt"
	fi
#get the number of files in each list again, to cause a break when we run out
	n1files=`wc -l ${lang1_name}.txt | awk '{print $1}' `
	n2files=`wc -l ${lang2_name}.txt | awk '{print $1}' `

#and update end, to cause a break when we run out
	end=$(($end + 100 ))

echo NEW WHILE $n1files $n2files $end $max1 $max2
done


echo "done mixing lines for gold and tags"
