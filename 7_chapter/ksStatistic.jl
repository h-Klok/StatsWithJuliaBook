using Random, Distributions, StatsBase, HypothesisTests, PyPlot
Random.seed!(0)

function ksStat(dist)
    data = rand(dist,n)
    Fhat = ecdf(data)
    sqrt(n)*maximum(abs.(Fhat(xGrid) - cdf(dist,xGrid)))
end

n = 25
N = 10^5
xGrid = -10:0.001:10
kGrid = 0:0.01:5

dist1 = Exponential(1)
kStats1 = [ksStat(dist1) for _ in 1:N]

dist2 = Normal()
kStats2 = [ksStat(dist2) for _ in 1:N]

figure(figsize=(10,5))
subplot(121)
plt.hist(kStats1,50,color="b",label="KS stat (Exponential)",histtype="step",
		normed=true)
plot(kGrid,pdf(Kolmogorov(),kGrid),"r",label="Kolmogorov PDF")
legend(loc="upper right")
xlim(0,2.5)

subplot(122)
plt.hist(kStats2,50,color="b",label="KS stat (Normal)",histtype="step",
		normed=true)
plot(kGrid,pdf(Kolmogorov(),kGrid),"r",label="Kolmogorov PDF")
legend(loc="upper right")
xlim(0,2.5)
