using Distributions, PyPlot

lambda, N = 1/3, 10^5
bulbs = [1,10,50]
xGrid = 0:0.1:10
C = ["b","r","g"]

dists = [Gamma(n,1/(n*lambda)) for n in bulbs]

for (n,d) in enumerate(dists)
    sh = Int64(shape(d))
    sc = scale(d)
    data = [sum(-(1/(sh*lambda))*log.(rand(sh))) for _ in 1:N]
    plt.hist(data,50,color=C[n], histtype = "step", density="true")
    plot(xGrid,pdf.(d,xGrid),C[n],
        label="Shape = $(sh), Scale = $(round(sc,digits=2))")
end
xlabel("x")
ylabel("Probability")
xlim(0,maximum(xGrid))
legend(loc="upper right")
