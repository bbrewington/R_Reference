# VectorSplitExtract: splits a homogeneous vector using strsplit, then extracts one of the elements
# Definition of homogeneous: all elements have same structure

VectorSplitExtract <- function(data, regex, elementnum){
  sapply(strsplit(data, regex), "[[", elementnum)
}