#!/bin/bash

set -e

wget "$1" # fetches the remote bundle (.tar.gz file) using the url passed in as first argument

file_name=$(basename "$1") # gets the base name of the file without the full path (ex. basename /home/usr/path/filetxt becomes file.txt)

tar -xzvf "$file_name" # decompress the tar.gz file 

tsv_file=$(tar -tzf "$file_name" | grep '\.tsv$') # gets the name of the .tsv file in the tarball

csv_file="${tsv_file%.tsv}.csv"

tr '\t' ',' < "$tsv_file" > "$csv_file"

