using CSV, Distributions, HypothesisTests

data = CSV.read("../data/machine1.csv", header=false)[:,1]
xBar, n = mean(data), length(data)
sig = 1.2
alpha = 0.1
z = quantile(Normal(),1-alpha/2)

println("Calculating formula: ", (xBar - z*sig/sqrt(n), xBar + z*sig/sqrt(n)))
println("Using confint() function: ", confint(OneSampleZTest(xBar,sig,n),alpha))
