using Distributions, Calculus ,PyPlot

xGrid = -5:0.01:5
sig = 1.5
normalDensity(z) = pdf(Normal(0,sig),z)

d0 = normalDensity.(xGrid)
d1 = derivative.(normalDensity,xGrid)
d2 = second_derivative.(normalDensity, xGrid)

plot(xGrid,d0)
plot(xGrid,d1)
plot(xGrid,d2)