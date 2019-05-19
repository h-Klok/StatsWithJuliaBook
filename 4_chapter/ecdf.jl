using Random, Distributions, StatsBase, PyPlot
Random.seed!(0)

underlyingDist = Normal(20,5)
data = rand(underlyingDist, 15)

empiricalCDF = ecdf(data)

xGrid = 0:0.1:40
plot(xGrid,cdf(underlyingDist,xGrid),"-r",label="Underlying CDF")
plot(xGrid,empiricalCDF(xGrid),label="ECDF")
xlim(0,40)
ylim(0,1)
xlabel(L"x")
legend(loc="upper left")
