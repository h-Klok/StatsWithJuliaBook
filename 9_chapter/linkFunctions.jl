using GLM, RDatasets, DataFrames, Distributions, PyPlot, Random, LinearAlgebra
Random.seed!(0)

df = dataset("MASS", "cpus")
n = size(df)[1]
df = df[shuffle(1:n),:]

pTrain = 0.2
lastTindex = Int(floor(n*(1-pTrain)))
numTest = n - lastTindex

train = df[1:lastTindex,:]
test = df[lastTindex+1:n,:]

formula = @formula(Perf~CycT+MMin+MMax+Cach+ChMin+ChMax)
model1 = glm(formula, train, Normal(),  IdentityLink())
model2 = glm(formula, train, Poisson(), LogLink())
model3 = glm(formula, train, Gamma(),  InverseLink())

invIdenityLink(x) = x
invLogLink(x) = exp(x)
invInverseLink(x) = 1/x

A = [ones(numTest) test.CycT test.MMin test.MMax test.Cach test.ChMin test.ChMax]
pred1 = invIdenityLink.(A*coef(model1))
pred2 = invLogLink.(A*coef(model2))
pred3 = invInverseLink.(A*coef(model3))

actual = test.Perf
lossModel1 = norm(pred1 - actual)
lossModel2 = norm(pred2 - actual)
lossModel3 = norm(pred3 - actual)

println("Model 1: ", coef(model1))
println("Model 2: ", coef(model2))
println("Model 3: ", coef(model3))
println("\nLoss of models 1,2,3: ",(lossModel1 ,lossModel2, lossModel3))
