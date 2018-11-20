#!/bin/bash

#change absurd file names (spaces, periods, etc., where they don't belong) to sth less stupid (underscores)
#this file needs to be present in the folder where files are to be renamed
#by default, everything (files and folders) that can be renamed will be

#Franziska Schmidt
#2018/11/19

#########################################################################################
#start loop over content of current folder (also subfolders)
function renameFiles {
	#echo "WTF"
	for FNAME in * #every file, ./*/ is every directory
	do
		#announce file name to be changed
		echo "Renaming file $FNAME"
		
		#ignore directories for now
		if [[ -d "$FNAME" ]]
		then
			(cd "$FNAME" && echo $(pwd) && renameFiles && cd ~-)
		fi
		
		#file path and name are identical for files and folders
		path=$(pwd)
		filename=$(basename -- "$FNAME")
		
		if [[ -d "$FNAME" ]]
		then
			extension="" #empty extension for folders
		else
			extension=".${filename##*.}" #grab extension for files
		fi
		filename="${filename%.*}" #get filename without extension
		
		#rename
		newName="${filename//[![:alnum:]]/_}$extension"
		mv "$path/$filename$extension" "$path/$newName"
		
		#announce result
		echo "$FNAME is now called $path/$newName"
	done
}

renameFiles
