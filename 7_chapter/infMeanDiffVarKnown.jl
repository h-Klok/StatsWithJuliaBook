using CSV, Distributions, HypothesisTests

data1 = CSV.read("../data/machine1.csv", header=false)[:,1]
data2 = CSV.read("../data/machine2.csv", header=false)[:,1]
xBar1, n1 = mean(data1), length(data1)
xBar2, n2 = mean(data2), length(data2)
sig1, sig2 = 1.2, 1.6
delta0 = 0

testStatistic = ( xBar1-xBar2 - delta0 ) / ( sqrt( sig1^2 / n1 + sig2^2 / n2 ) )
pVal = 2*ccdf(Normal(), abs(testStatistic))

println("Sample mean machine 1: ",xBar1)
println("Sample mean machine 2: ",xBar2)
println("Manually calculated test statistc: ", testStatistic)
println("Manually calculated p-value: ", pVal)
