using Distributions

xObs     = [18 132; 45 178]
rowSums  = [sum(xObs[i,:]) for i in 1:2]
colSums  = [sum(xObs[:,i]) for i in 1:2]
n        = sum(xObs)

rowProps = rowSums/n
colProps = colSums/n

xExpect  = [colProps[c]*rowProps[r]*n for r in 1:2, c in 1:2]
testStat = sum([(xObs[r,c]-xExpect[r,c])^2 / xExpect[r,c] for r in 1:2,c in 1:2])
pVal = ccdf(Chisq(1),testStat)

println("Chi-squared value: ", testStat)
println("P-value: ", pVal)