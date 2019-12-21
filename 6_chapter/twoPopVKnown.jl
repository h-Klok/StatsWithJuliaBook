using CSV, Distributions, HypothesisTests

data1 = CSV.read("../data/machine1.csv", header=false)[:,1]
data2 = CSV.read("../data/machine2.csv", header=false)[:,1]
xBar1, xBar2 = mean(data1), mean(data2)
n1, n2 = length(data1), length(data2)
sig1, sig2 = 1.2, 1.6
alpha = 0.05
z = quantile(Normal(),1-alpha/2)

println("Calculating formula: ", (xBar1 - xBar2 - z*sqrt(sig1^2/n1+sig2^2/n2),
				  xBar1 - xBar2 + z*sqrt(sig1^2/n1+sig2^2/n2)))
