using CSV, Distributions, HypothesisTests

data = CSV.read("../data/machine1.csv", header=false)[:,1]
xBar, n = mean(data), length(data)
sigma = 1.2
mu0A, mu0B = 52.2, 53

testStatistic = ( xBar - mu0A ) / ( sigma/sqrt(n) )
pVal = 2*ccdf(Normal(), abs(testStatistic))

testA = OneSampleZTest(xBar, sigma, n, mu0A)
testB = OneSampleZTest(xBar, sigma, n, mu0B)

println("Results for mu0 = ", mu0A,":")
println("Manually calculated test statistic: ", testStatistic)
println("Manually calculated p-value: ", pVal,"\n")
println(testA)

println("\n In case of  mu0 = ", mu0B, " then p-value = ", pvalue(testB))
