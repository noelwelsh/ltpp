# Setup LTPP data
#
# Actual data is not included with the code as I don't have
# permission to reproduce it. I assume it is in the same
# directory as the code

source('base.r')

rawData = read.delim('ltpp-data.txt', header=TRUE, sep='\t')

# Select the first set of variables we're interested in, scale it, and drop NAs
#
# Dependent variables is column 63 in raw data, column 1 in this data
trafficData = preprocess(rawData[,c(63,10,11,12)], 1)


# preprocess(Data.Frame) -> Data.Frame
#
# Perform standard preprocessing on data:
# - normalise
# - exclude NaNs
# - exclude duplicates
preprocess = function(data) {
  as.data.frame(unique(na.exclude(normalise(data))))
}
