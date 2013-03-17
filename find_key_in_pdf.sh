#!/bin/bash

# Recursively searches for keywords in pdf files placed at the directory given by SEARCH_DIR.
# To add a keyword create a directory with the keyword in a directory named keys which has to
# exist in the directory, from which the script is called. The results of the search is saved in
# textfiles named by the file they where found in, placed in the directory belonging to the keyword.
# SEARCH_DIR has to be changed to the directory the pdf files to be searched in are. 
#
# Example: to search for the keywords "long", "short" and "fat" create the directories ./keys/long,
# ./keys/short and ./keys/fat before running the script. The results are saved in this directories.

SEARCH_DIR="/change/"

# recursively lists all pdfs in directory
find "$SEARCH_DIR" -type f -name "*.pdf" |
# for each pdf
while read pdf; do
	# if it is a file
	if test -f "$pdf"; then
		# for each given keyword
		for key in `ls keys`; do
			# convert pdf to text, grep the keyword and store the result in the keywords directory
			pdftotext "$pdf" /dev/stdout | grep -H -- "$key" > "./keys/$key/`(basename "$pdf")`.txt"
			# if filesize is 0 (keyword not found), remove file
		done
	fi
done
# delete all empty files where keyword has not been found
find ./keys/ -type f -empty -delete
