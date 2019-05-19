using DataFrames, GLM, PyPlot, CSV

data = CSV.read("polynomialData.csv")
data.X2 = abs2.(data.X)
model = lm(@formula(Y ~ X + X2), data)

xGrid = -5:0.1:5
yHat(x) = coef(model)[3]*x.^2 + coef(model)[2]*x + coef(model)[1]
plot(data.X, data.Y, ".b")
plot(xGrid, yHat.(xGrid), "r")
println(model)
