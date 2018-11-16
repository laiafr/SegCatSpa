
#!/usr/bin/env bash
# cleaning up selected lines from cha files in prep to generating a phono format
# Alex Cristia alecristia@gmail.com 2015-10-26
LC_CTYPE=C
#########VARIABLES
#Variables that have been passed by the user
SELFILE=$1
ORTHO=$2
#########

echo "Cleaning $SELFILE"

#replacements to clean up CHAT style punctuation, etc. -- usually ok regardless
#of the corpus
grep "*" < "$SELFILE" |
sed 's/^....:.//g' |
sed "s/\_/ /g" |
sed '/^0(.*) .$/d' |
sed  's/\..*$//g' | #this code deletes bulletpoints (Û+numbers
sed  's/\?.*$//g' | 
sed  's/\!.*$//g' | 
tr -d '\"' |
tr -d '\^' | 
tr -d "\'" |
tr -d '\/' |
sed 's/\+/ /g' |
tr -d '\.' |
tr -d '\?' |
tr -d '!' |
tr -d ';' |
tr -d "⌉" |
tr -d '\<' |
tr -d '\>' |
tr -d ','  |
tr -d ':'  |
tr -d '~'  |
tr -d '“' |
tr -d '”' |
tr -d '⌈' |
tr -d '⌉' |
tr -d "^?" |
tr -d "^?" |
grep -v "^\[-" | # IMPORTANT CHOICE -- deleting sentences that are code-switched
sed 's/&=[^ ]*//g' | 
#sed 's/&[^ ]*//g' |  #delete words beginning with & ##IMPORTANT CHOICE COULD HAVE CHOSEN TO DELETE SUCH NEOLOGISMS/NONWORDS by uncommenting this
sed 's/\[.*\]//g' | #delete comments
sed 's/([^(]*)//g' | #IMPORTANT CHOICE -- UNCOMMENT THIS LINE AND COMMENT OUT THE NEXT TO DELETE MATERIAL NOTED AS NOT PRONOUNCED
#sed 's/(//g' | sed 's/)//g' | #IMPORTANT CHOICE -- UNCOMMENT THIS LINE AND COMMENT OUT THE PRECEDING TO REMOVE PARENTHESES TAGGING UNPRONOUNCED MATERIAL
sed 's/xxx//g' |
sed 's/www//g' |
sed 's/XXX//g' |
sed 's/yyy//g' |
sed 's/^0.*//g' | #remove comment phrases eg 0 [=! comiendo] 
sed 's/[^ ]*@s:[^ ]*//g' | #delete words tagged as being a switch into another language
#sed 's/[^ ]*@o//g' | #delete words tagged as onomatopeic
sed 's/@[^ ]*//g' | #delete tags beginning with @ IMPORTANT CHOICE, COULD HAVE CHOSEN TO DELETE FAMILIAR/ONOMAT WORDS
sed "s/\'/ /g"  |
tr -d '-'  | #use carefully -- some corpora use "-" as a morhpeme boundary marker
tr -s ' ' |
sed 's/ $//g' |
sed 's/^ //g' |
sed 's/^[ ]*//g' |
sed 's/ $//g' |
sed '/^$/d' |
sed '/^ $/d' |
sed 's/\^//g' |
tr -d "[" |
tr -d "]" |
tr -d '\t' |
awk '{gsub("\"",""); print}' > $ORTHO


#This is to process all the "junk" that were generated when making the
#changes from included to ortho.  For e.g., the cleaning process
#generated double spaces between 2 words (while not present in
#included)
sed -i -e 's/ $//g' $ORTHO

