using Distributions, PyPlot

V = [1, 3, 100]
xGrid = -5:0.1:5

plot(xGrid,pdf(Normal(),xGrid),label="Normal Distribution")
[plot(xGrid, pdf(TDist(v),xGrid),"+",label="DOF = $v") for v in V]
xlim(-4,4)
ylim(0,0.5)
xlabel(L"$x$")
ylabel(L"$f(x)$")
legend(loc="upper right")
savefig("tDistribution.png")
