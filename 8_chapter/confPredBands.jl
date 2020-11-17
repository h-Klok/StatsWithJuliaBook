using CSV, GLM, Distributions, Plots; pyplot()
data = CSV.read("../data/weightHeight.csv")
n = size(data)[1]
model = fit(LinearModel, @formula(Height ~ Weight), data)

alpha = 0.1
tVal = quantile(TDist(n-2),1-alpha/2)

xbar = mean(data.Weight)
Sxx = std(data.Weight)*(n-1)
MSE = deviance(model)/(n-2)
pred(x) = coef(model)'*[1, x]

interval(x,sign,prediction = 0) = sign(pred(x),
			tVal * sqrt(MSE*(prediction+1/n+(x-xbar)^2/Sxx)) )

xGrid = 40:1:140
scatter(data.Weight, data.Height, c=:black, ms=2, label="")
plot!(xGrid,pred.(xGrid), c=:red, label="Linear model")
plot!(xGrid,interval.(xGrid,+),c=:green, label="Confidence bands")
plot!(xGrid,interval.(xGrid,-),c=:green, label="")
plot!(xGrid,interval.(xGrid,+,1),c=:blue,label="Prediction bands")
plot!(xGrid,interval.(xGrid,-,1), 
	c=:blue, label="", xlims=(40, 120), ylims=(145, 200), legend=:topleft,
	xlabel = "Weight (kg)", ylabel = "Height (cm)")