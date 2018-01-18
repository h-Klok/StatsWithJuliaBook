using Distributions, PyPlot

lambda = 1/3
N = 10^5
C = ["b","r","g"]
xGrid = 0:0.1:10

dists = [Gamma(n,1/(n*lambda)) for n in [1,10,50]]

for (n,d) in enumerate(dists)
    sh = Int64(shape(d))
    sc = scale(d)
    data = [sum(-(1/(sh*lambda))*log.(rand(sh))) for _ in 1:N]
    plt[:hist](data,50,normed=true,lw=0.5,alpha=0.5,color=C[n])
    plot(xGrid,pdf(d,xGrid),C[n],label="Shape = $(sh), Scale = $(round(sc,2))")
end
xlim(0,maximum(xGrid));
legend(loc="upper right")
savefig("gammaDist.png")