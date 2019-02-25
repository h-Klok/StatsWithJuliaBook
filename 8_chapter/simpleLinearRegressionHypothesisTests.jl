using DataFrames, GLM, PyPlot, Distributions, CSV

data = CSV.read("weightHeight.csv")
mData = sort(data, :Weight)[1:20,:]

model = lm(@formula(Height ~ Weight), mData)
pred(x) = coef(model)'*[1, x]

plot(mData.Weight, mData.Height,"b.")

xlims = [minimum(mData.Weight), maximum(mData.Weight)]
plot(xlims,pred.(xlims),"r")

tStat = coef(model)[2]/stderror(model)[2]
n = size(mData)[1]
pVal = 2*ccdf(TDist(n-2),tStat)
println("Manual Pval: ", pVal)
println(model)
