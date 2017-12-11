# Princeton Applied Research M250/270 electrochemistry data cleaner
Working up data from this software was *really* tedious (see, [workflow video I made for colleagues](https://www.youtube.com/watch?v=rU0EtnfCsc8)); I wrote a python script to automate the process and save hours of mindless work.  
It has a catchy and memorable name so exhausted 4th year grad students doomed to use the namesake software can find salvation with a Google search.

`cleanCloner.py` outputs 2 files, one with the data cleaned and all run together (\<original_filename>\_cleanBig.csv) and one with the data separated into runs based on the starting value (\<original_filename>\_cleanSplit.csv).  
Supports processing multiple files at once (`ctrl`+`click` or `shift`+`click`).

_Must be run with Python 3, requires Tkinter._

There are also R scripts to:  
1) Plot each scan as a different color so you can more easily visualize changes between scans.  
![Image from sample data](/extra/fc_example.png?raw=true "Ferrocene with 10 scans")  
2)  Show the plotting over time, which may be useful for teaching CV (includes option to plot voltage sweeping).  
![GIF from sample data](/extra/ggplot_fc_animated.gif?raw=true "1 scan of Ferrocene animated, Solarized 2 theme")
![Voltage sweep](/extra/v_sweep_fc_animated.gif?raw=true "1 scan of Ferrocene with voltage sweep")
