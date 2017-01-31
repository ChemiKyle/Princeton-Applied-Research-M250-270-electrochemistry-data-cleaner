#!/bin/env/python3

import csv, os
from tkinter.filedialog import askopenfilename 

file = askopenfilename()
filename, file_extension = os.path.splitext(file)
file = open(file)

headEnd = 46
dataRows = []

def removeSet(data, Y1):
	result = []
	for row_num, row in enumerate(data):
		if row_num > 0 and row[1] == Y1:
			break
		result.append(row)
	if row_num == len(data)-1:
		row_num += 1
	data = data[row_num:]
	return result, data

with file as csvFileObj:
	readerObj = csv.reader(csvFileObj)

	# Take out all header rows
	for row in readerObj:
		if readerObj.line_num < headEnd:
			continue
		row = row[0].strip().split(" ") # Split into list
		# If the V value is positive it is separated by 2 spaces, leaving the data in list[2], this corrects that
		if row[1] == '':
			del row[1]
		dataRows.append(row[:2])

# Write a cleaned file with all runs in one set
big_out = filename + "_cleanBig" + file_extension
with open(big_out, "w") as f:
    f.write("A,V\n")
    for row in dataRows:
        f.write(row[0] + "," + row[1] + "\n")


Y1 = dataRows[0][1]
largest_data_set = 0
data_sets = []

# Create data sets by searching for Y1 in the data
while(len(dataRows) > 0):
    data_set, dataRows = removeSet(dataRows, Y1)
    data_sets.append(data_set)
    if len(data_set) > largest_data_set:
        largest_data_set = len(data_set)

# Make all of the data sets the same size
for i in range(len(data_sets)):
    pad_rows = largest_data_set - len(data_sets[i])
    for j in range(pad_rows):
        data_sets[i].append(["",""])


# Write a cleaned file with all runs separated
split_out = filename + "_cleanSplit" + file_extension
with open(split_out, "w") as f:
    # Write header row
    f.write("A,V")
    for i in range(1, len(data_sets)):
        f.write(",,A,V")
    f.write("\n")

    for row_num in range(largest_data_set):
        f.write(",".join(data_sets[0][row_num]))
        for i in range(1, len(data_sets)):
            f.write(",," + ",".join(data_sets[i][row_num]))
        f.write("\n")
