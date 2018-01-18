using Distributions, PyPlot

lambda = 1

expDist = Exponential(1/lambda)
geomDist = Geometric(1-e^-lambda)

expGrid = 0:0.1:6
geomGrid =0:1:6

plot(expGrid,pdf(expDist,expGrid))
plt[:stem](geomGrid,pdf(geomDist,geomGrid),basefmt="none")
xlim(0,6)
ylim(0,1)
