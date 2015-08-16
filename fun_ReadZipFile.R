## Read a zip file from a url without downloading the file
## Source: http://stackoverflow.com/questions/3053833/using-r-to-download-zipped-data-file-extract-and-import-data

fileurl <- "http://www.newcl.org/data/zipfiles/a1.zip"
temp <- tempfile()
download.file(fileurl, temp)
data <- read.table(unz(temp, "a1.dat"))
unlink(temp)
