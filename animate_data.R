fname = file.choose()
echem <- read.csv(fname)
title_name = tools::file_path_sans_ext(basename(fname))


x <- echem$V
y <- echem$A
y <- y * 10 ** 6
xy <- data.frame(x, y)

# Toggles
show_V = F # Show graph of voltage sweeping over time, not working w ggplot
use_base = show_V # Use base graphics instead of ggplot, tied to show_V

colFunc <- colorRampPalette(c("midnightblue","navy", "navyblue",
                              "royalblue4", "lightblue", "peru")) #itsgreatUF

draw.baseplot <- function(i) {
  if(show_V) {
    par(mfrow=c(2, 1)) # Include in same graph
    plot(x[1:i],
         ylim = range(x), xlim = c(1,length(x)), pch = 20, cex = 1.5,
         ylab = "Potential (V)", xlab="Time", xaxt = 'n',
         col = colFunc(length(x[1:i])), # Plotted points "cool" over time
         main = "Voltage Sweep"
    )
  }
  plot(x[1:i], y[1:i],
       ylim = range(y), xlim = range(x), pch = 20, cex = 1.5,
       xlab = "Potential (V)", ylab = expression(paste("Current (", mu, "A)")),
       col = colFunc(length(x[1:i])),
       main = paste("Cyclic Voltammogram of", title_name)
  )
}

draw.ggplot <- function(i) {
  p <- ggplot(data = xy[1:i,], aes(x=x[1:i], y=y[1:i])) +
    geom_point(color = colFunc(length(x[1:i])), size = 1.5) +
    labs(x = "Potential (V)", y = expression(paste("Current (", mu, "A)")),
         title = paste("Cyclic Voltammogram of", title_name)) +
    xlim(range(x)) + ylim(range(y))
  if (show_V) { # Currently not working properly, but throws no errors
    pV <- ggplot(data = xy[1:i,], aes(x = length(x[1:i]), y = x[1:i])) +
      geom_point(color = colFunc(length(x[1:i])), size = 1.5) +
      labs(x = "Time", y = "Potential (V)",
           title = "Voltage Sweep") +
      xlim(c(1, length(x))) + ylim(range(x))
    plot_grid(p, pV, ncol = 1, nrow = 2)
    } else {
    print(p)
    }
}

anim.plot <- function(plot_opt) {
  for(i in seq_along(x)) {
    plot_opt(i)
  }
}

library(animation)
saveGIF({
  if (require('ggplot2') && !use_base) {
    anim.plot(draw.ggplot)
  } else {
    anim.plot(draw.baseplot)
  }
}, interval = 0.01, movie.name = paste(title_name, ".gif", sep=''))
