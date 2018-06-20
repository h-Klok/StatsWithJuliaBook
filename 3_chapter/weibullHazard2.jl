# QQQQ create an xgrid and do a plot
using Distributions, PyPlot

A = [0.5 1.5 1]
dists = [Weibull(a,2) for a in A]

N = 10^5
x = 1:0.1:5

d = 2
data = rand(dists[d],N);
delta = 0.0001

println(pdf(dists[d],x)/(1-cdf(dists[d],x)))

dataMoreThan5 = filter(z->(z>x),data)
dataInDeltaMoreThan5 = filter(z->(z<x+delta),dataMoreThan5)
(length(dataInDeltaMoreThan5)/length(dataMoreThan5))/delta
