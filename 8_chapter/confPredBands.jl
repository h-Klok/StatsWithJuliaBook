using DataFrames, GLM, PyPlot, Distributions

data = readtable("weightHeight.csv")
model = fit(LinearModel, @formula(Height ~ Weight), data)

xGrid = 40:1:140

alpha = 0.05
n = size(data)[1]
xbar = mean(data[:Weight])
sx = std(data[:Weight])
pred(x) = coef(model)'*[1, x]

confInt(x,sign) = sign(pred(x), quantile(TDist(n-2),1-alpha/2)*
    sqrt(deviance(model)/(n-2))*sqrt(1/n +(x-xbar)^2/((n-1)*sx^2) ) )
predInt(x,sign) = sign(pred(x), quantile(TDist(n-2),1-alpha/2)*
    sqrt(deviance(model)/(n-2))*sqrt(1+ 1/n +(x-xbar)^2/((n-1)*sx^2) ) )

plot(data[:Weight], data[:Height],".k")
plot(xGrid,pred.(xGrid),"r",label="Linear model")
plot(xGrid,confInt.(xGrid,+),"g",label="Confidence interval")
plot(xGrid,confInt.(xGrid,-),"g")
plot(xGrid,predInt.(xGrid,+),"b",label="Prediciton interval")
plot(xGrid,predInt.(xGrid,-),"b")
xlim(39, 110)
ylim(145, 200)
legend(loc="upper left")