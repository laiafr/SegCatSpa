#!/bin/sh
# Laia Fibla laia.fibla.reixachs@gmail.com 2017-04-20
# minor edits Alex Cristia alecristia@gmail.com 2018-10-25
# This scripts calculates the syllable, phone and word inventory of two corpora and allows to find out the differences

######### VARIABLES ##########

lang1=$1
lang2=$2
output=$3

echo  $lang1 $lang2 $output #just to check

##############################

#declare useful function
function countchar()
{
    while IFS= read -r i; do printf "%s" "$i" | tr -dc "$1" | wc -m; done
}

#Extract phone, syllable & word inventory
for thisfile in $lang1/1/tags.txt $lang2/1/tags.txt; do
  sed 's/;eword/;esyll/g' < $thisfile | sed 's/ //g' | sed 's/;esyll/%/g' | tr '%' '\n' | sed '/^$/d' |
    sort | uniq -c | awk '{print $2}' > ${thisfile}-syllables.txt
  sed 's/;esyll//g' < $thisfile | sed 's/ //g' | sed 's/;eword/%/g' | tr '%' '\n' | sed '/^$/d' |
sort | uniq -c | awk '{print $2}' > ${thisfile}-words.txt
  sed 's/;esyll//g' < $thisfile | sed 's/;eword//g' | sed 's/ /%/g' | tr '%' '\n' | sed '/^$/d' |
sort | uniq -c | awk '{print $2}' > ${thisfile}-phones.txt

done

  # Look at the differences
diff $lang1/1/tags.txt-phones.txt $lang2/1/tags.txt-phones.txt > $output/phone_differences.txt

num_phone_l1=`wc -l $lang1/1/tags.txt-phones.txt | awk '{print $1}'`
num_phone_l2=`wc -l $lang2/1/tags.txt-phones.txt | awk '{print $1}'`

phone_uniq_l1=`grep '<' < $output/phone_differences.txt | wc -l | awk '{print $1}'`
phone_uniq_l2=`grep '>' < $output/phone_differences.txt | wc -l | awk '{print $1}'`


diff $lang1/1/tags.txt-syllables.txt $lang2/1/tags.txt-syllables.txt > $output/syll_differences.txt

num_syll_l1=`wc -l $lang1/1/tags.txt-syllables.txt | awk '{print $1}'`
num_syll_l2=`wc -l $lang2/1/tags.txt-syllables.txt | awk '{print $1}'`

syll_uniq_l1=`grep '<' < $output/syll_differences.txt | wc -l | awk '{print $1}'`
syll_uniq_l2=`grep '>' < $output/syll_differences.txt | wc -l | awk '{print $1}'`


diff $lang1/1/tags.txt-words.txt $lang2/1/tags.txt-words.txt > $output/word_differences.txt

num_word_l1=`wc -l $lang1/1/tags.txt-words.txt | awk '{print $1}'`
num_word_l2=`wc -l $lang2/1/tags.txt-words.txt | awk '{print $1}'`

word_uniq_l1=`grep '<' < $output/word_differences.txt | wc -l | awk '{print $1}'`
word_uniq_l2=`grep '>' < $output/word_differences.txt | wc -l | awk '{print $1}'`


echo num_phone_l1 num_phone_l2 phone_uniq_l1 phone_uniq_l2 num_syll_l1 num_syll_l2 syll_uniq_l1 syll_uniq_l2 num_word_l1 num_word_l2 word_uniq_l1 word_uniq_l2 > $output/summary-comparison.txt
echo $num_phone_l1 $num_phone_l2 $phone_uniq_l1 $phone_uniq_l2 $num_syll_l1 $num_syll_l2 $syll_uniq_l1 $syll_uniq_l2 $num_word_l1 $num_word_l2 $word_uniq_l1 $word_uniq_l2 >> $output/summary-comparison.txt





