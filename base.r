# Basic definitions used by all LTPP code

# colVars(Matrix) -> Matrix
# Compute the variance of each column in x
#
# Taken from https://stat.ethz.ch/pipermail/r-help/2002-March/019606.html
colVars = function(x, na.rm=FALSE, dims=1, unbiased=TRUE, SumSquares=FALSE,
                    twopass=FALSE) {
  if (SumSquares) return(colSums(x^2, na.rm, dims))
  N <- colSums(!is.na(x), FALSE, dims)
  Nm1 <- if (unbiased) N-1 else N
  if (twopass) {x <- if (dims==length(dim(x))) x - mean(x, na.rm=na.rm) else
                     sweep(x, (dims+1):length(dim(x)), colMeans(x,na.rm,dims))}
  (colSums(x^2, na.rm, dims) - colSums(x, na.rm, dims)^2/N) / Nm1
}

# normalise(Matrix, Vector) -> Matrix
# Scale data to zero mean and unit standard deviation
#
# Columns listed in excludedCols are not scaled. This should
# be used to specify, e.g., the dependent (aka output or
# 'variable you are trying to predict') variables
normalise = function(data, excludedCols) {
  dependents = data[,excludedCols]
  scaled = scale(data[,-excludedCols])

  result = cbind(dependents, scaled)
  # Preserve any column names
  colnames(result) = colnames(data)
  result
}

# test((Data.Frame -> [0,1]), Data.Frame, Natural) -> Natural
#
# Computes the number of misclassifications made by predict
# on data where dependentCol is the column in data
# indicating the target.
#
# Assumes the target is a binary variable, and thresholds
# the results of predict at 0.5
test = function(predict, data, dependentCol) {
  predictions = predict(data)
  # Convert to an array of binary variables, where true (=1) if prediction > 0.5
  thresholded = predictions > 0.5
  # Actual values
  actual = data[,dependentCol]

  # Count the number of misclassifications
  sum((actual - thresholded)^2)
}
