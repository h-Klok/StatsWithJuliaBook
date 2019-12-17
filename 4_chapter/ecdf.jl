using Random, Distributions, StatsBase, Plots; pyplot()
Random.seed!(0)

mu1, sigma1 = 10, 5
mu2, sigma2 = 40, 12
dist1, dist2 = Normal(mu1,sigma1), Normal(mu2,sigma2)
p = 0.3
mixRv() = (rand() <= p) ? rand(dist1) : rand(dist2)
mixCDF(x) = p*cdf(dist1,x) + (1-p)*cdf(dist2,x)

n = [30, 100]
data1 = [mixRv() for _ in 1:n[1]]
data2 = [mixRv() for _ in 1:n[2]]

empiricalCDF1 = ecdf(data1)
empiricalCDF2 = ecdf(data2)

xGrid = -10:0.1:80
plot(xGrid,empiricalCDF1.(xGrid), c=:blue, label="ECDF with n = $(n[1])")
plot!(xGrid,empiricalCDF2.(xGrid), c=:red, label="ECDF with n = $(n[2])")
plot!(xGrid, mixCDF.(xGrid), c=:black, label="Underlying CDF",
    xlims=(-10,80), ylims=(0,1), 
    xlabel="x", ylabel="Probability", legend=:topleft)