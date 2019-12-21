using CSV, Distributions, HypothesisTests

data1 = CSV.read("../data/machine1.csv", header=false)[:,1]
data2 = CSV.read("../data/machine2.csv", header=false)[:,1]
xBar1, xBar2 = mean(data1), mean(data2)
s1, s2 = std(data1), std(data2)
n1, n2 = length(data1), length(data2)
alpha = 0.05

v = (s1^2/n1 + s2^2/n2)^2 / ( (s1^2/n1)^2 / (n1-1) + (s2^2/n2)^2 / (n2-1) )

t = quantile(TDist(v),1-alpha/2)

println("Calculating formula: ", (xBar1 - xBar2 - t*sqrt(s1^2/n1 + s2^2/n2),
				  xBar1 - xBar2 + t*sqrt(s1^2/n1 + s2^2/n2)))
println("Using confint(): ",   confint(UnequalVarianceTTest(data1,data2),alpha))
