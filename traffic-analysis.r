# Before this code works you might need to execute from within R
#
# install.packages('scatterplot3d')

require('scatterplot3d')
source('data.r')
source('logistic-regression.r')

# Analysis of the traffic data set

# Plot the traffic data in three dimensions distinguishing class by colour
plotTrafficData = function() {
  ## Here we drop the dependent variable, for ease of plotting
  trueCases  = trafficData[trafficData[,1] == 1,][,c(2,3,4)]
  falseCases = trafficData[trafficData[,1] == 0,][,c(2,3,4)]
  
  xlim = c(max(max(trueCases[,1]), max(falseCases[,1])),
    min(min(trueCases[,1]), min(falseCases[,1])))
  ylim = c(max(max(trueCases[,2]), max(falseCases[,2])),
    min(min(trueCases[,2]), min(falseCases[,2])))
  zlim = c(max(max(trueCases[,3]), max(falseCases[,3])),
    min(min(trueCases[,3]), min(falseCases[,3])))

  graph = scatterplot3d(trueCases, color='red', xlim=xlim, ylim=ylim, zlim=zlim)
  graph$points3d(falseCases, col='blue')
  graph
}

print('Analysing traffic data')
print('Plotting data')
plotTrafficData()
print('Number of folds in cross-validation')
print(nFolds)
print('Errors on the traffic data using logistic regression (absolute and percentage)')
nErrors = trafficLogisticRegression()
print(nErrors)
print(nErrors / (dim(trafficData)[1]))
