using Distributions, PyPlot

triangDist = TriangularDist(0,2,1)
xGrid = 0:0.1:2
N = 10^6
inverseSampledData = quantile.(triangDist,rand(N))

plt.hist(inverseSampledData,50, normed = true,ec="k",
        label="Inverse transform\n sampled data")
plot(xGrid,pdf(triangDist,xGrid),"r",label="PDF")
legend(loc="upper right")
