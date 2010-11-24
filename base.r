# Basic definitions used by all LTPP code

#
# Some variables that control global behaviour
#

# Number of folds in cross-validation
nFolds = 10



#
# Function definitions
#

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

# empiricalRisk(Vectorof{0,1}, Vectorof[0,1]) -> Natural
#
# Computes the empirical risk under the 0-1 Loss. Assumes
# true is a vector of binary values, and predictions is a
# vector of probabilities. Predictions is thresholded at 0.5
empiricalRisk = function(target, predictions) {
  # Convert to an array of binary variables, where true (=1) if prediction > 0.5
  thresholded = predictions > 0.5
  # Count the number of misclassifications
  risk = sum((target - thresholded)^2)
  risk
}
