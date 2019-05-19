using DataFrames, GLM, PyPlot, Distributions, CSV

data = CSV.read("weightHeight.csv")
sData = sort(data, :Weight)[1:20,:]

model = lm(@formula(Height ~ Weight), sData)
pred(x) = coef(model)'*[1, x]

plot(sData.Weight, sData.Height,"b.")

xlims = [minimum(sData.Weight), maximum(sData.Weight)]
plot(xlims,pred.(xlims),"r")

tStat = coef(model)[2]/stderror(model)[2]
n = size(sData)[1]
pVal = 2*ccdf(TDist(n-2),tStat)
println("Manual Pval: ", pVal)
println(model)
