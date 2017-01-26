import csv

directory = "/path/to/directory"
fileName = "target_file_name"
fileLoc = directory + fileName + ".csv"

headEnd = 46

dataRows =[]

csvFileObj = open(fileLoc)
readerObj = csv.reader(csvFileObj)

# Take out all header rows
for row in readerObj:
	if readerObj.line_num < headEnd:
		continue
	row = row[0][:23] # Truncate off weird superfluous data
	dataRows.append(row.strip())

outName = fileName + "_Clean" + ".csv"

outFile = open(outName, 'w')
outFile.write("A,V\n")

for row in dataRows:
	row = row.replace(" ", ",") # make it formatted like a csv
	row = row.replace(",,", ",") # fix accidental stupid
	outFile.write(row + "\n")

outFile.close()
