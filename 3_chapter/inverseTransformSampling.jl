using Distributions, PyPlot

invExp(lambda) = -log(1-rand())/lambda
expDist = Exponential(1/lambda)

lambda, N = 2, 10^6
xGrid = 0:0.1:2*lambda

figure(figsize=(8,5))
plt[:hist]([invExp(lambda) for _ in 1:N],100,ec="black",lw=0.5,normed=true,
        label="Inverse transform\n sampled data")
plot(xGrid,pdf(expDist,xGrid),"r",label="Analytic PDF")
legend(loc="upper right")
xlim(0,lambda)
ylim(0,lambda)
savefig("inverseTransformSampling.png")
