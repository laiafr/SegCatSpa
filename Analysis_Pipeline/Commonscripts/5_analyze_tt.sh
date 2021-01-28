#!/usr/bin/env bash
# Script for analyzing mono and bilingual corpus with diferent mixings - M2 SegCatSpa - -- adapted for separate train test
# Alex Cristia alecristia@gmail.com 2021-01 -- based on other analyze

######### VARIABLES ###############

train_input_dir=$1
test_input_dir=$2
output_dir=$3

##################################

echo $train_input_dir
echo $test_input_dir

# wordseg tool to launch segmentation pipelines on the cluster
wordseg_slurm="/shared/apps/wordseg/tools/wordseg-slurm.sh"

# the token separators in the tags files
separator="-p' ' -s';esyll' -w';eword'"


# get the list of tags files in the input_dir, assuming that what gets passed is a folder containing tags (i.e. no embedding)
all_tags="$test_input_dir/*tags.txt"
ntags=$(echo $all_tags | wc -w)
echo "found $ntags tags files in $train_input_dir"

# temporary jobs file to list all the wordseg jobs to execute
jobs=$(mktemp)
trap "rm -rf $jobs" EXIT

# build the list of wordseg jobs from the list of tags files
counter=1
for tags in $all_tags
do
    name=$(basename $tags | cut -d- -f1)
    train="$train_input_dir/$name"
    echo -n "[$counter/$ntags] building jobs for $name"
    echo "  test $tags"
    echo "  train $train..."

    # defines segmentation jobs
#    echo "$name-syllable-tprel $tags,$train syllable $separator wordseg-tp -v -t relative " >> $jobs
#    echo "$name-syllable-tpabs $tags,$train syllable $separator wordseg-tp -v -t absolute " >> $jobs
#    echo "$name-phone-dibs $tags,$train phone $separator wordseg-dibs -v -t phrasal -u phone " >> $jobs
#    echo "$name-phone-puddle $tags,$train phone $separator wordseg-puddle -v  -w 2  " >> $jobs
    echo "$name-syllable-ag $tags,$train syllable $separator wordseg-ag -vv -j 8 " >> $jobs

    ((counter++))
    echo " done"

    # # for testing, process only some tags
    # [ $counter -eq 1 ] && break
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
conda deactivate

