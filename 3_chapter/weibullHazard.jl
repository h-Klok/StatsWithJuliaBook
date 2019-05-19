using Distributions, PyPlot

A = [0.5 1.5 1]
dists = [Weibull(a,2) for a in A]
xGrid = 0:0.01:10
C = ["b", "r", "g"]

for (n,d) in enumerate(dists)
    plot(xGrid,pdf(d,xGrid)./(ccdf(d,xGrid)),C[n],
    label="Shape = $(shape(d)), Scale = 2")
end
xlabel("x")
ylabel("Instantaneous failure rate")	
xlim(0,10)
ylim(0,3)
legend(loc="upper right")
