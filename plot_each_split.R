# Plot each scan from a clean_split file in one color coded plot

fname = file.choose()

echem <- read.csv(fname)
echem <- echem[colSums(!is.na(echem)) > 0] # get rid of the empty buffer columns
title_name = tail(strsplit(fname, '/')[[1]], 1) # Get the file name without preceding path to use as title

line_width = 2
pairs = length(echem)/2 - 1
color_list = c('red', 'orange', 'yellow', 'blue', 'purple', 'pink') # Create color vector to cycle through for scan number

scan <- data.frame(echem[2], echem[1])
plot(scan, type='l', lwd = line_width, xlab = 'V', ylab='A')

for (i in 1:pairs) {
  scan <- data.frame(echem[i*2], echem[1+i*2])
  lines(scan, lwd = line_width, col = color_list[i])
}

title(title_name, sub = "Individual scans")
# I can't figure out how to get the legend function to work with this