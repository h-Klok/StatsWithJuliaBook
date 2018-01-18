using Distributions, PyPlot

tDist = TriangularDist(0,2,1)
N = 10^6
inverseSampledData = quantile.(tDist,rand(N))

figure(figsize=(8,5))
plt[:hist](inverseSampledData,50,ec="black",lw=0.5,normed=true,
        label="Inverse transform\n sampled data")
plot(xGrid,pdf(tDist,xGrid),"r",label="Analytic PDF")
legend(loc="upper right")
savefig("triangularDistInv.png");
