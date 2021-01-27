#!/usr/bin/env bash
# Script for analyzing mono and bilingual corpus with diferent mixings - M2 SegCatSpa -
# Alex Cristia alecristia@gmail.com 2016-11
# Adapted by Laia Fibla 2017-03-15 laia.fibla.reixachs@gmail.com
# minor changes Alex Cristia 2018-10-12

######### VARIABLES ###############

input_dir=$1
output_dir=$2

##################################

# wordseg tool to launch segmentation pipelines on the cluster
wordseg_slurm="/shared/apps/wordseg/tools/wordseg-slurm.sh"

# the token separators in the tags files
separator="-p' ' -s';esyll' -w';eword'"


# get the list of tags files in the input_dir, assuming that what gets passed is a folder containing tags (i.e. no embedding)
all_tags="$input_dir/*tags.txt"
ntags=$(echo $all_tags | wc -w)
echo "found $ntags tags files in $input_dir"

# temporary jobs file to list all the wordseg jobs to execute
jobs=$(mktemp)
trap "rm -rf $jobs" EXIT

# build the list of wordseg jobs from the list of tags files
counter=1
for tags in $all_tags
do
    name=$(basename $tags | cut -d- -f1)
    echo -n "[$counter/$ntags] building jobs for $name ..."


    # defines segmentation jobs
    echo "$name-syllable-baseline-00 $tags syllable $separator wordseg-baseline -v -P 0" >> $jobs
    echo "$name-syllable-baseline-10 $tags syllable $separator wordseg-baseline -v -P 1" >> $jobs
    echo "$name-syllable-tprel $tags syllable $separator wordseg-tp -v -t relative" >> $jobs
    echo "$name-syllable-tpabs $tags syllable $separator wordseg-tp -v -t absolute" >> $jobs
    echo "$name-phone-dibs $tags phone $separator wordseg-dibs -v -t phrasal -u phone $tags" >> $jobs
    echo "$name-phone-puddle $tags phone $separator wordseg-puddle -v -j 5 -w 2" >> $jobs
    echo "$name-syllable-ag $tags syllable $separator wordseg-ag -vv -j 8" >> $jobs

    ((counter++))
    echo " done"

    # # for testing, process only some tags
    # [ $counter -eq 4 ] && break
done


# load the wordseg python environment
module load anaconda/3
source activate /shared/apps/anaconda3/envs/wordseg

# launching all the jobs
echo -n "submitting $(cat $jobs | wc -l) jobs ..."
$wordseg_slurm $jobs $output_dir > /dev/null
echo " done"

echo "all jobs submitted, writing to $output_dir"
echo "view status with 'squeue -u $USER'"

# unload the environment
source deactivate

