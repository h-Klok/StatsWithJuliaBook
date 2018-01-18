using Distributions, PyPlot

A = [0.5 1.5 1]
dists = [Weibull(a,2) for a in A]
xGrid = 0:0.01:10

[plot(xGrid,pdf(d,xGrid)./(1-cdf(d,xGrid)),label="Shape = $(shape(d)), 
	Scale = 2") for d in dists]
xlim(0,10)
ylim(0,3)
legend(loc="upper right")
savefig("weibullHazard.png")
