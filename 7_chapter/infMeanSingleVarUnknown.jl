using CSV, Distributions, HypothesisTests

data = CSV.read("machine1.csv", header=false, allowmissing=:none)[:,1]
xBar, n = mean(data), length(data)
s = std(data)
mu0 = 52.2

testStatistic = ( xBar - mu0 ) / ( s/sqrt(n) )
pVal = 2*ccdf(TDist(n-1), abs(testStatistic))

println("Manually calculated test statistic: ", testStatistic)
println("Manually calculated p-value: ", pVal)
OneSampleTTest(data, mu0)
