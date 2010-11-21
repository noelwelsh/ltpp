# Baseline results: logistic regression

source('base.r')
source('data.r')

# TODO: Cross validation or at least testing/training split

formula = RUT_FAILURE ~ TMS_AADT + Total_pc_heavy + CumESA_Base_millions

model = glm(formula, family=binomial(link='logit'), trafficData)
errors = test(function(data) { predict(model, data, type='response') }, trafficData, 1)
