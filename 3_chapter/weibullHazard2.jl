N = 10^7
x = 2

d = 2
data = rand(dists[d],N);
delta = 0.0001
println(pdf(dists[d],x)/(1-cdf(dists[d],x)))

dataMoreThan5 = filter(z->(z>x),data)
dataInDeltaMoreThan5 = filter(z->(z<x+delta),dataMoreThan5)
(length(dataInDeltaMoreThan5)/length(dataMoreThan5))/delta
