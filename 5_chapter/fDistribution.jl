using Distributions, PyPlot

n1, n2 = 10, 15
N = 10^6
mu, sigma = 10, 4
normDist = Normal(mu,sigma)

fValues = Array{Float64}(undef, N)

for i in 1:N
    data1 = rand(normDist,n1)
    data2 = rand(normDist,n2)
    fValues[i] = var(data1)/var(data2)
end

xRange = 0:0.1:5

plt.hist(fValues,400,histtype="step",color="b",
    label="Simulated",normed=true)
plot(xRange,pdf(FDist(n1-1, n2-1), xRange),"r",label="Analytic")
xlim(0,5)
legend(loc="upper right")
