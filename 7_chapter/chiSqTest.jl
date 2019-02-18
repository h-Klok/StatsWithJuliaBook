using Distributions, HypothesisTests

p = [0.08, 0.12, 0.2, 0.2, 0.15, 0.25]
O = [3, 2, 9, 11, 8, 27]
M = length(O)
n = sum(O)
E = n*p

testStatistic = sum((O-E).^2 ./E)
pVal = ccdf(Chisq(M-1), testStatistic)

println("Manually calculated test statistic: ", testStatistic)
println("Manually calculated p-value: ", pVal,"\n")

println(ChisqTest(O,p))