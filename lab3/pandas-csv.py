#!/usr/local/bin/python3

import pandas as pd
import sys


if len(sys.argv) < 2: # checks if a file was passed in
    print("Please pass in a .csv file to be processed: ./pandas-csv.py <file.csv>")
    sys.exit(2)

input_file = sys.argv[1] # grabs the file passed in and store it in a variable

df = pd.read_csv(input_file) # uses pandas to read the .csv file

print(f'Original line count: {len(df)}') # counts the lines before processing

df.dropna(inplace=True) # removes rows with NaN or empty in a cell

print(f'Line count after NaN/empty cell row removal: {len(df)}') # counts the lines after taking out rows with NaN/empty cells

df.drop_duplicates(inplace = True) # removes rows that are duplicates

print(f'Line count after removing duplicates: {len(df)}')

df.to_csv('cleaned_' + input_file, index=False, header=True) # stores the cleaned data into a new .csv file with cleaned_ appended to the start
