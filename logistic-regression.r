# Baseline results: logistic regression

require('boot')

source('base.r')
source('data.r')

trafficFormula = RUT_FAILURE ~ TMS_AADT + Total_pc_heavy + CumESA_Base_millions

# logisticRegression(Formula, Data.Frame)
#
# Computes the empirical risk under the 0-1 Loss for a logistic regression model
logisticRegression = function(formula, data) {
  model  = glm(formula, family=binomial(link='logit'), trafficData)
  errors = cv.glm(trafficData, model, empiricalRisk, nFolds)
  errors$delta[2] * nFolds
}

trafficLogisticRegression = function() {
  logisticRegression(trafficFormula, trafficData)
}
