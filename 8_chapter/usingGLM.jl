using DataFrames, GLM, PyPlot, Statistics

data = readtable("weightHeight.csv")

lm1 = lm(@formula(Height ~ Weight), data)
lm2 = fit(LinearModel,@formula(Height ~ Weight), data) 

glm1 = glm(@formula(Height ~ Weight), data, Normal(), IdentityLink())
glm2 = fit(GeneralizedLinearModel,@formula(Height ~ Weight), data, Normal(), 
	IdentityLink()) 

println("***Output of LM Model:")
println(lm1)

println("\n***Output of GLM Model")
println(glm1)

println("\n***Individual methods applied to model output:")

println("Deviance: ",deviance(lm1))
println("Standard error: ",stderror(lm1))
println("Degrees of freedom: ",dof_residual(lm1))
println("Covariance matrix: ",vcov(lm1))

yVals = data[:Height]
SStotal = sum((yVals .- mean(yVals)).^2)

println("R squared (calculated in two ways):\n",r2(lm1),",\t",
    1 - deviance(lm1)/SStotal)
pred(x) = coef(lm1)'*[1, x]

xlims = [minimum(data[:Weight]), maximum(data[:Weight])]
plot(data[:Weight], data[:Height],"b.")
plot(xlims, pred.(xlims),"r")
xlim(xlims)
xlabel("Weight (kg)")
ylabel("Height (cm)")
