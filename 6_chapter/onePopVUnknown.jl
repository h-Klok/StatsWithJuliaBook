using CSV, Distributions, HypothesisTests

data = CSV.read("../data/machine1.csv", header=false)[:,1]
xBar, n = mean(data), length(data)
s = std(data)
alpha = 0.1
t = quantile(TDist(n-1),1-alpha/2)

println("Calculating formula: ", (xBar - t*s/sqrt(n), xBar + t*s/sqrt(n)))
println("Using confint() function: ", confint(OneSampleTTest(xBar,s,n),alpha))