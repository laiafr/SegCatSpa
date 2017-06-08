Notes recipe creation: 
Analisis of English  -  Spanish corpora and creation of a Bilingual mixed corpus

-------

# Step 1: Database creation

This script cleans up the .cha files. It removes all caracters that are not orthorgraphical.
It also selects the speackers that will be analysed. 

--> Alternative: the macth_phones.sh code uses an alreaddy phonologized transcript (tags.txt) and adapts it to the phoneme inventory 
of another language E.g. in this case the Bernstein corpus to match the phone notation in the Spanish corpus

# Step 2: Phonologization // now done in step 1

This steps translates the orthographical files into its phonological version in three possible ways (depending on the language): eSpeak,
FESTIVAL and simple rules that we applied ourslefs in the scripts. 
Since eSpeak contained several errors, they were corrected by rules.  

---> Additional step: to be able to concatenate, Here we cut the big coprus in small parts that will be concatenated in the next step 

# Step 3: Concatenation

This step mixes each 4 and each 100 lines from english and spanish files.
This will allow comparison with the bilingual mixed files that will also combine languages each 4 or each 100 lines. 

There is one script for the concatenation of the monolingual corpus and a different one for the bilingual coprus. 
The bilingual script is the one that does the mixing between English and Spanish. 
 

# Step 5: Cutting 

This step cuts the English coprus, the spanish corpus and the bilingual corpus in 10 parts. This is to measure how variable are
the segmentaiton scores obtained in the next step. It allows to compute the SD and SE. 

This step is also used to divide the bilingual corpus in two parts (sine the combiantion of English and spanish would result
in a corpus double the size. 
 

# Step 5: Segmentation 

Segment the coprus with several algorithms. You can choose which ones you want to use by includeing them in the script.


# Step 5: Compilation of the results

This setp extracts all the results and compilates them in a single .txt. 


# Bigwrap: By runing it you go thought all the previous steps

