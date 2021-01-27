#!/bin/sh
# Wrapper to take a single cleaned up transcript and phonologize it
# Alex Cristia alecristia@gmail.com 2015-10-26
# Modified by Laia Fibla laia.fibla.reixachs@gmail.com 2016-09-28
# Adapted to castillan spanish and catalan using espeak
# minor alex 2018-10-12

## Activate espeak ##

#echo "ja estic funcionant" | phonemize -l ca # testing espeak

######### VARIABLES #################
#Variables to modify
LANGUAGE=$1 #language options: spa (castillan spanish), cat (catalan)  -- NOTICE, IN SMALL CAPS
# e.g. LANGUAGE="catalan"


RES_FOLDER=$2
#this is where we will put the processed versions of the transcripts - E.g. RES_FOLDER="/fhgfs/bootphon/scratch/lfibla/seg/SegCatSpa/big_corpora/RES_corpus_cat/"
# NOTICE THE / AT THE END OF THE NAME
#####################################

for ORTHO in ${RES_FOLDER}/*ortholines.txt; do
	KEYNAME=$(basename "$ORTHO" -ortholines.txt)

	#########
	if [ "$LANGUAGE" = "cat" ]
	   then
	  echo "recognized $LANGUAGE"

		echo "using espeak"
		phonemize -l ca $ORTHO -o ${RES_FOLDER}/${KEYNAME}-phono.tmp

		echo "substituting phones" # correcting phones or exchanging caracters, some cannot be processed by the perl script
		sed 's/ t / t/g' ${RES_FOLDER}/${KEYNAME}-phono.tmp |
		sed 's/ɛssə/s/g' |
		sed 's/ s / s/g' |
		sed 's/^s /s/g' |
		sed 's/^t / t/g' |
		sed 's/d‍ʑiʎəm/giʎəm/g' |
		sed 's/ɣujʎəm/giʎəm/g' |
		sed 's/ d‍ʑiʎəm$/ giʎəm/g' |
		sed 's/^d‍ʑiʎəm$/giʎəm/g' |
		sed 's/ d‍ʑiʎəm / giʎəm /g' |
		sed 's/ d‍ʑi/ gi/g' |
		sed 's/^d‍ʑi/gi/g' |
		sed 's/ɣwe/gwe/g' |
		sed 's/ɣwi/gwi/g' |
		sed 's/ɣwj/gwi/g' |
		sed 's/ɣ/g/g' |
		sed 's/gʊa/gwa/g' |
		sed 's/gʊo/gwo/g' |
		sed 's/gʊu/gu/g' |
		sed 's/gʊe/ge/g' |
		sed 's/gʊi/gi/g' |
		sed 's/gua/gwa/g' |
		sed 's/gue/ge/g' |
		sed 's/gui/gi/g' |
		sed 's/guo/gwo/g' |
		sed 's/gwu/gu/g' |
		sed 's/β/b/g' |
		sed 's/ʋ/b/g' |
		sed 's/ð/9/g' |
		sed 's/^ɛs /əs /g' |
		sed 's/ɛs$/əs/g' |
		sed 's/ ɛs / əs /g' |
		sed 's/dʑi/gi/g' |
		sed 's/dʑe/ge/g' |
		sed 's/dʑ/G/g' |
		sed 's/ʑ/J/g' |
		sed 's/jɕʊ /6ɔ /g' |
		sed 's/jɕʊ$/6ɔ/g' |
		sed 's/ kotɕə / koX2 /g' |
		sed 's/ kotɕə$/ koX2/g' |
		sed 's/tɕ/X/g' |
		sed 's/ɕ/6/g' |
		sed 's/ɲ/N/g' | #ñ
		sed 's/mp /m /g' |
		sed 's/mp$/m/g' |
		sed 's/kʊi/ki/g' |
		sed 's/kʊe/ke/g' |
		sed 's/kui/ki/g' |
		sed 's/kue/ke/g' |
		sed 's/ pɛrʊ / pərɔ /g' |
		sed 's/ anəm / anem /g' |
		sed 's/ɐ/a/g' |
		sed 's/ ɛʎ/ eʎ/g' |
		sed 's/^ɛʎ/eʎ/g' |
		sed 's/ ɛʎ/ eʎ/g' |
		sed 's/^ɛʎ/eʎ/g' |
		sed 's/ə/2/g' |
		sed 's/ʎ/L/g' |
		sed 's/ʊ/u/g' | #old 0
		sed 's/ɔ/O/g' |
		sed 's/ɛ/3/g' |
		sed 's/ɾr/R/g' |
		sed 's/ ɾr/ R/g' |
		sed 's/^ɾr/R/g' |
		sed 's/r/R/g' |
		sed 's/ r/ R/g' |
		sed 's/^r/R/g' |
		sed 's/rr/R/g' |
		sed 's/ɾ/r/g' |
		sed 's/ŋ/7/g' |
		sed 's/ aia/ iaia/g' |
		sed 's/ aia$/ iaia/g' |
		sed 's/ aia / iaia /g' |
		sed 's/ 3la / l/g' |
		sed "s/' //g" |
		sed "s/ '//g" |
		sed "s/'//g" |
		sed 's/Gi/gi/g' | # ?
		sed 's/Gi /gi /g' |
		sed 's/Gi$/gi/g' |
		sed 's/ë/e/g' |
		sed 's/suzaɡna/suzana/g' |
		sed 's/ɡ/g/g' |
		sed 's/ɟ/t/g' |
		sed 's/⌈//g' |
		sed 's/ː//g' |
		sed 's/koX2/koX2/g' |
		sed 's/‍//g' |
		sed 's/dz/D/g' |
		sed 's/tz/D/g' |
		sed 's/ts/5/g' |
		sed 's/"//g' |
		sed 's/ai/aj/g' |
		sed 's/ei/ej/g' |
		sed 's/2i/2j/g' |
		sed 's/3i/3j/g' |
		sed 's/oi/oj/g' |
		sed 's/Oi/Oj/g' |
		sed 's/ui/uj/g' |
		sed 's/au/aw/g' |
		sed 's/eu/ew/g' |
		sed 's/2u/2w/g' |
		sed 's/3u/3w/g' |
		sed 's/iu/iw/g' |
		sed 's/ou/ow/g' |
		sed 's/Ou/Ow/g' |
		sed 's/uu/uw/g' |
		sed 's/ia/ja/g' |
		sed 's/ie/je/g' |
		sed 's/i2/j2/g' |
		sed 's/i3/j3/g' |
		sed 's/io/jo/g' |
		sed 's/iO/jO/g' |
		sed 's/iu/ju/g' |
		sed 's/ua/wa/g' |
		sed 's/ue/we/g' |
		sed 's/u2/w2/g' |
		sed 's/u3/w3/g' |
		sed 's/ui/wi/g' |
		sed 's/uo/wo/g' |
		sed 's/uO/wO/g' |
		sed 's/ieu/jew/g' |
		sed 's/i2u/j2w/g' |
		sed 's/i3w/j3w/g' |
		sed 's/ueu/wew/g' |
		sed 's/u2u/w2w/g' |
		sed 's/u3u/w3w/g' |
		sed 's/^pese3fa$//g' |
		sed 's/ˌ//g' > ${RES_FOLDER}/${KEYNAME}-intoperl.tmp

	  echo "syllabify-corpus.pl"
	  perl catspa-syllabify-corpus.pl catalan ${RES_FOLDER}/${KEYNAME}-intoperl.tmp ${RES_FOLDER}/${KEYNAME}-outofperl.tmp $PATH_TO_SCRIPTS

	elif [ "$LANGUAGE" = "spa" ]
		 then
		echo "recognized $LANGUAGE"
	tr '[:upper:]' '[:lower:]'  < "$ORTHO"  |
		sed 's/ch/T/g' | # substitute all ch by tS
		sed 's/tx/T/g' |
		sed 's/C/T/g' |
		sed 's/^x/T/g' |
		sed 's/x/ks/g' |
		sed 's/á/a/g' |
		sed 's/é/e/g' |
		sed 's/ë/e/g' |
		sed 's/ë/e/g' |
		sed 's/í/i/g' |
		sed 's/ï�/i/g' |
		sed 's/í/i/g' |
		sed 's/í/i/g' |
		sed 's/ó/o/g' |
		sed 's/ú/u/g' |
		sed 's/v/b/g' |
		sed 's/z/8/g' |
		sed 's/ce/8e/g' |
		sed 's/ci/8i/g' |
		sed 's/ll/L/g' | # very mixed in spain choose between L and y
		sed 's/d/9/g' |
		sed 's/^9/d/g' |
		sed 's/9l/dl/g' |
		sed 's/9n/dn/g' |
		sed 's/rr/R/g' | # substitute the spanish rr by 5
		sed 's/ r/ R/g' |# substitute word-initial r for R
		sed 's/^r/R/g' | # substitute sentence-initial r for R
		sed 's/sr/sR/g' |
		sed 's/nr/nR/g' |
		sed 's/lr/lR/g' |
		sed 's/j/x/g' |
		sed 's/ge/xe/g' |
		sed 's/gi/xi/g' |
		sed 's/gua/gwa/g' |
		sed 's/guo/gwo/g' |
		sed 's/gui/gi/g' |
		sed 's/gue/ge/g' |
		sed 's/qu/k/g' |
		sed 's/cua/kwa/g' |
		sed 's/cuo/kwo/g' |
		sed 's/c/k/g' |
		sed 's/hi/j/g' |
		sed 's/hu/w/g' |
		sed 's/h//g' |
		sed 's/ñ/N/g' |
		sed 's/ü/w/g' |
		sed 's/au/aw/g' |
		sed 's/eu/ew/g' |
		sed 's/iu/iw/g' |
		sed 's/ou/ow/g' |
		sed 's/ua/wa/g' |
		sed 's/ue/we/g' |
		sed 's/uia/wja/g' |
		sed 's/ui/wi/g' |
		sed 's/uo/wo/g' |
		sed 's/uay/waj/g' |
		sed 's/uey/wej/g' |
		sed 's/uau/waw/g' |
		sed 's/ay/aj/g' |
		sed 's/ey/ej/g' |
		sed 's/oy/oj/g' |
		sed 's/uy/uj/g' |
		sed 's/iai/jaj/g' |
		sed 's/ia/ja/g' |
		sed 's/iei/jej/g' |
		sed 's/ie/je/g' |
		sed 's/io/jo/g' |
		sed 's/iu/ju/g' |
		sed 's/yo/jo/g' |
		sed 's/ya/ja/g' |
		sed 's/ye/je/g' |
		sed 's/yi/ji/g' |
		sed 's/yu/ju/g' |
		sed 's/y/i/g' |
		sed 's/⌉//g' |
		sed 's/⌋//g' |
		sed 's/⌈//g' |
		sed 's/ː//g' |
		sed 's/ˌ//g' |
		sed 's/"//g' > ${RES_FOLDER}/${KEYNAME}-intoperl.tmp

		echo "syllabify-corpus.pl"
		perl catspa-syllabify-corpus.pl cspanish ${RES_FOLDER}/${KEYNAME}-intoperl.tmp ${RES_FOLDER}/${KEYNAME}-outofperl.tmp $PATH_TO_SCRIPTS

	elif [ "$LANGUAGE" = "eng" ]
	   then
	  echo "recognized $LANGUAGE"

		echo "using festival"
		phonemize -l en-us-festival -s "/" $ORTHO -o ${RES_FOLDER}/${KEYNAME}-phono.tmp

		#rewrite symbols to have the corresponding sounds in both english and spanish conveyed with the same character
		sed 's/jh/1/g' ${RES_FOLDER}/${KEYNAME}-phono.tmp |
		sed 's/th/8/g' |
		sed 's/ch/T/g' |
		sed 's/sh/S/g' |
		sed 's/dh/9/g' |
		sed 's/sh/S/g' |
		sed 's/zh/Z/g' |
		sed 's/uh/U/g' |
		sed 's/ih/I/g' |
		sed 's/aa/A/g' |
		sed 's/ae/E/g' |
		sed 's/ah/V/g' |
		sed 's/ao/O/g' |
		sed 's/ax/2/g' |
		sed 's/eh/3/g' |
		sed 's/er/4/g' |
		sed 's/hh/h/g' |
		sed 's/ng/7/g' |
		sed 's/uw/u/g' |
		sed 's/ow/o_w/g' |
		sed 's/oy/o_y/g' |
		sed 's/iy/i/g' | 
		sed 's/aw/a_w/g' |
		sed 's/ay/a_y/g' |
		sed 's/ey/e_y/g' |
		sed 's/y/j/g' > ${RES_FOLDER}/${KEYNAME}-outofperl.tmp


	fi

	echo "removing blank lines"
	sed '/^$/d' ${RES_FOLDER}/${KEYNAME}-outofperl.tmp |
	sed 's/ $//' |
	sed '/^ $/d'  |
	sed '/^[ ]*$/d'  |
	sed 's/^[ ]*//'  |
	sed 's/[ ]*$//'  |
	sed 's/^\///'  | #remove syllable boundary at the beginning of sentences
	sed 's/ \// /g'  | #remove syllable boundary at the beginning of words
	sed 's/\/$//'  | #remove syllable boundary at the end of sentences
	tr -s ' ' |
	sed 's/ /\/#/g' |
	sed 's/\/\//\//g' |
	sed -e 's/\(.\)/\1 /g'  |
	sed 's/$/\/#/' | #add syll and word tag at end of sentence
	tr -s '\\' |
	sed 's/\// ;esyll /g'| #replace shorthand with true tags
	sed 's/#/ ;eword /g' |
	tr '_' ' ' |  #to deal with diphthongs
	tr -s ' ' > ${RES_FOLDER}/${KEYNAME}-tags.txt


done

echo $RES_FOLDER
echo "done phonologize"

#rm ${RES_FOLDER}/${KEYNAME}-*.tmp
