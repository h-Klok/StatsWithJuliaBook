using Distributions, PyPlot

cUnif = Uniform(0,2*pi)
xGrid, N = 0:0.1:2*pi, 10^6

plt.hist(rand(N)*2*pi,50, histtype = "step", density = true,
    label="MC Estimate")
plot(xGrid,pdf.(cUnif,xGrid),"r",label="PDF")
legend(loc="upper right")
ylim(0,0.2)
