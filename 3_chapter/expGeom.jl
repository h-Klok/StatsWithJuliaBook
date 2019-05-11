using StatsBase, Distributions, PyPlot

lambda, N = 1, 10^6
xGrid = 0:6

expDist = Exponential(1/lambda)
floorData = counts(convert.(Int,floor.(rand(expDist,N))), xGrid)/N
geomDist = Geometric(1-MathConstants.e^-lambda)

stem(xGrid,floorData,label="Floor of Exponential",basefmt="none")
plot(xGrid,pdf(geomDist,xGrid),"rx",ms=8,label="Analytic Geometric")
ylim(0,1)
xlabel("x")
ylabel("Probability")
legend(loc="upper right")
