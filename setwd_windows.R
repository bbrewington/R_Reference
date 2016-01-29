# Set working directory by copy + pasting address from Windows Explorer
# (Windows Explorer uses backslashes, which R doesn't support)

# How to use this:
#  1. Copy + Paste below code into R, which will prompt you with the text shown below
#  2. Copy address from Windows Explorer, and paste into R
#  --> working directory is now set to that address

setwd(gsub("\\\\","/",readline(prompt = "Copy + Paste data download directory path from Windows Explorer: ")))
