#!/bin/env/python3

import csv, os
from tkinter.filedialog import askopenfilename

def get_file():
	file = askopenfilename()
	filename, file_extension = os.path.splitext(file)
	file = open(file)
	file_info = [file, filename, file_extension]
	return file_info

headEnd = 46

# file_info = get_file()

def fill_array(file_info):
	with file_info[0] as file:
		data_rows = []
		readerObj = csv.reader(file)
		# Take out all header rows
		for row in readerObj:
			if readerObj.line_num < headEnd:
				continue
			row = row[0].strip().split(" ") # Split into list
			# If the V value is positive it is separated by 2 spaces, leaving the data in list[2], this corrects that
			if row[1] == '':
				del row[1]
			data_rows.append(row[:2])

	return data_rows

# data_rows = fill_array(file_info)

# Write a cleaned file with all runs in one set, i.e. as a 2*m matrix
def big_writer(file_info, data_rows):
	big_out = file_info[1] + "_cleanBig" + file_info[2]
	with open(big_out, "w") as f:
		f.write("A,V\n")
		for row in data_rows:
			f.write(row[0] + "," + row[1] + "\n")

# big_writer(file_info, data_rows)

def removeSet(data, initial_V):
	result = []
	for row_num, row in enumerate(data):
		if row_num > 0 and row[1] == initial_V:
			break
		result.append(row)
	if row_num == len(data)-1:
		row_num += 1
	data = data[row_num:]
	return result, data

# Write a cleaned file separated by runs
def run_parser(file_info, data_rows):
	initial_V = data_rows[0][1]
	largest_data_set = 0
	data_sets = []

	# Create data sets by searching for initial_V in the data
	while(len(data_rows) > 0):
		data_set, data_rows = removeSet(data_rows, initial_V)
		data_sets.append(data_set)
		if len(data_set) > largest_data_set:
			largest_data_set = len(data_set)

	# Make all of the data sets the same size
	for i in range(len(data_sets)):
		pad_rows = largest_data_set - len(data_sets[i])
		for j in range(pad_rows):
			data_sets[i].append(["",""])


	# Write a cleaned file with all runs separated
	split_out = file_info[1] + "_cleanSplit" + file_info[2]
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

# run_parser(data_rows)


def main():
	file_info = get_file()
	data_rows = fill_array(file_info)
	big_writer(file_info, data_rows)
	run_parser(file_info, data_rows)

if __name__ == '__main__':
	main()