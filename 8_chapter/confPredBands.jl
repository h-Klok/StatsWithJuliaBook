using DataFrames, GLM, PyPlot, Distributions, CSV

data = CSV.read("weightHeight.csv")
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
plot(data.Weight, data.Height,".k")
plot(xGrid,pred.(xGrid),"r",label="Linear model")
plot(xGrid,interval.(xGrid,+),"g",label="Confidence interval")
plot(xGrid,interval.(xGrid,-),"g")
plot(xGrid,interval.(xGrid,+,1),"b",label="Prediciton interval")
plot(xGrid,interval.(xGrid,-,1),"b")
xlim(40, 120)
ylim(145, 200)
legend(loc="upper left")
