using CSV, Distributions, HypothesisTests

data1 = CSV.read("machine1.csv", header=false, allowmissing=:none)[:,1]
data2 = CSV.read("machine2.csv", header=false, allowmissing=:none)[:,1]
xBar1, xBar2 = mean(data1), mean(data2)
s1, n1 = std(data1), length(data1)
s2, n2 = std(data2), length(data2)
delta0 = 0

v = ( s1^2/n1 + s2^2/n2 )^2 / ( (s1^2/n1)^2/(n1-1) + (s2^2/n2)^2/(n2-1)  )
testStatistic = ( xBar1-xBar2 - delta0 )  / sqrt( s1^2/n1 + s2^2/n2 )
pVal = 2*ccdf(TDist(v), abs(testStatistic))

println("Manually calculated degrees of freedom, v: ", v)
println("Manually calcualted test statistc: ", testStatistic)
println("Manually calculated p-value: ", pVal)
println(UnequalVarianceTTest(data1, data2, delta0))
