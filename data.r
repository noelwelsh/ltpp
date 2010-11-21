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
trafficData = as.data.frame(na.exclude(normalise(rawData[,c(63,10,11,12)], 1)))
