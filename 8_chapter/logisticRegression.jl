using GLM, DataFrames, Distributions, Plots, CSV; pyplot()

data = CSV.read("../data/examData.csv")

model = glm(@formula(Pass ~ Hours), data, Binomial(), LogitLink())

pred(x) = 1/(1+exp(-(coef(model)[1] + coef(model)[2]*x)))

xGrid = 0:0.1:maximum(data.Hours)

scatter(data.Hours, data.Pass, c=:blue, msw=0)
plot!(xGrid, pred.(xGrid), 
	c=:red, xlabel="Hours studied", legend=:none, 
	xlims=(0, maximum(data.Hours)), yticks=([0:1;], ["Fail", "Pass"]))