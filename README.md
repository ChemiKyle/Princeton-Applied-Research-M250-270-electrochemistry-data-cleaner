# Princeton Applied Research M250/270 electrochemistry data cleaner
Working up data from this software was *really* tedious (see, [workflow video I made for colleagues] (https://www.youtube.com/watch?v=rU0EtnfCsc8)); I'm writing a python script to automate the process and save hours of mindless work.  
It has a catchy and memorable name so exhausted 4th year grad students doomed to use the namesake software can find salvation with a Google search.

Outputs 2 files, one with the data cleaned and all run together (\<original_filename>\_cleanBig.csv) and one with the data separated into runs based on the starting value (\<original_filename>\_cleanSplit.csv).  
GUI works on Ubuntu, don't have consistent access to Windows to test it out, but it should work in theory; in the event that it doesn't user will need to edit the code to point to their file.

_Must be run with Python 3, requires Tkinter._
