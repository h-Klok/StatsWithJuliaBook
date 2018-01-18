using Distributions, PyPlot

tDist = TriangularDist(0,2,1)
xGrid = 0:0.01:2
xGrid2 = 0:0.01:1

figure(figsize=(12.4,4))
subplots_adjust(wspace=0.4)

subplot(131)
plot(xGrid,pdf(tDist,xGrid))
xlabel("x")

subplot(132)
plot(xGrid,cdf(tDist,xGrid))
xlabel("x")

subplot(133)
plot(xGrid2,quantile(tDist,xGrid2))
xlabel("Quantile")

savefig("triangularDist.png");
