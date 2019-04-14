using GLM, RDatasets, DataFrames, Distributions, PyPlot, Random, LinearAlgebra
Random.seed!(0)
df = dataset("MASS", "cpus")
n = size(df)[1]
df = df[shuffle(1:n),:]

pTrain = 0.2
lastTindex = Int(floor(n*(1-pTrain)))
numTest = n - lastTindex

trainData = df[1:lastTindex,:]
testData = df[lastTindex+1:n,:]

formula = @formula(Perf~CycT+MMin+MMax+Cach+ChMin+ChMax)
model1 = glm(formula,trainData,Normal(),IdentityLink())
model2 = glm(formula,trainData,Poisson(),LogLink())
model3 = glm(formula,trainData,Gamma(),InverseLink())

invIdenityLink(x) = x
invLogLink(x) = exp(x)
invInverseLink(x) = 1/x

A = [ones(numTest) testData.CycT testData.MMin testData.MMax testData.Cach testData.ChMin testData.ChMax]
pred1 = invIdenityLink.(A*coef(model1))
pred2 = invLogLink.(A*coef(model2))
pred3 = invInverseLink.(A*coef(model3))

actual = testData[:Perf]
lossModel1 = norm(pred1 - actual)
lossModel2 = norm(pred2 - actual)
lossModel3 = norm(pred3 - actual)

println("Coef model 1:", coef(model1))
println("Coef model 2:", coef(model2))
println("Coef model 3:", coef(model3))
println("\nAccuracy of models 1,2,3: ",(lossModel1,lossModel2,lossModel3))
