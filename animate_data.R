fname = file.choose()
echem <- read.csv(fname)
title_name = tail(strsplit(fname, '/')[[1]], 1) # Get file name sans path


x <- echem$V
y <- echem$A
y <- y * 10 ** 6
z <- echem$Scan

show_V = F # Show graph of voltage sweeping over time

colFunc <- colorRampPalette(c("royalblue", "lightblue", "orange")) #itsgreatUF

library(animation)
saveGIF({
  for (i in seq_along(x)) {
    if(show_V) {
      par(mfrow=c(2, 1)) # Include in same graph
      plot(x[1:i],
           ylim = range(x), xlim = c(1,length(x)),
           ylab = "Potential (V)", xlab="time", xaxt = 'n',
           col = colFunc(length(x[1:i])), # Plotted points "cool" over time
           main = "Voltage Sweep"
      )
    }
    plot(x[1:i], y[1:i],
         ylim = range(y), xlim = range(x),
         xlab = "Potential (V)", ylab = expression(paste("Current (", mu, "A)")),
         col = colFunc(length(x[1:i])),
         main = paste("Cyclic Voltammogram of ", title_name)
         )
  }
}, interval = 0.01, movie.name = paste(title_name, ".gif"))
