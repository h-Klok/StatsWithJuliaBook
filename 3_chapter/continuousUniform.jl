using Distributions, PyPlot

cUnif = Uniform(0,2*pi)
xGrid, N = 0:0.1:2*pi, 10^6

plt[:hist](rand(N)*2*pi,50,ec="k",lw=0.5,normed=true,label="Numerical Estimate")
plot(xGrid,pdf(cUnif,xGrid),"r",label="Analytic Solution")
legend(loc="upper right")
ylim(0,0.2)
savefig("continuousUniform.png")
