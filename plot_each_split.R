# Plot each scan from a clean_split file in one color coded plot for quick analysis
# Not quite publication quality, but nice to visualize possible drift in successive scans

fname = file.choose()

echem <- read.csv(fname)
echem <- echem[colSums(!is.na(echem)) > 0] # get rid of the empty buffer columns
title_name = tail(strsplit(fname, '/')[[1]], 1) # Get the file name without preceding path to use as title

scan <- data.frame(echem[2], echem[1])
line_width = 2
plot(scan, type='l', lwd = line_width, xlab = 'V', ylab='A', col='red') # Initialize plot with first scan

# Split off data from each scan and plot in a different color
pairs = length(echem)/2
color_list = rainbow(pairs) # Not sure if colorblind friendly :(

for (i in 1:pairs) {
  scan <- data.frame(echem[i*2], echem[i*2-1])
  lines(scan, lwd = line_width, col = color_list[i])
}

title(title_name, sub = "Individual scans")
legend("topright", legend=c(1:pairs), col=color_list, lty=1, cex=0.8)