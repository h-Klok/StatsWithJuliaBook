using CSV, GLM, Plots; pyplot()

data = CSV.read("../data/polynomialData.csv")
data.X2 = abs2.(data.X)
model1 = lm(@formula(Y ~ X + X2), data)
model2 = lm(@formula(Y ~ X*X), data)
println(model1)
println(model2)

yHat(x) = coef(model1)[1] + coef(model1)[2]*x + coef(model1)[3]*x^2

xGrid = -5:0.1:5
scatter(data.X, data.Y, c=:blue, msw=0)
plot!(xGrid, yHat.(xGrid), 
    xlabel="X", ylabel="Y", c=:red, legend=:none)