using Distributions, StatsBase, HypothesisTests, Plots, Random; pyplot()
Random.seed!(0)

n = 25
N = 10^4
xGrid = -10:0.001:10
kGrid = 0:0.01:5
dist1, dist2 = Exponential(1), Normal()

function ksStat(dist)
    data = rand(dist,n)
    Fhat = ecdf(data)
    sqrt(n)*maximum(abs.(Fhat.(xGrid) - cdf.(dist,xGrid)))
end

kStats1 = [ksStat(dist1) for _ in 1:N]
kStats2 = [ksStat(dist2) for _ in 1:N]

p1 = stephist(kStats1, bins=50, 
	c=:blue, label="KS stat (Exponential)", normed=true)
p1 = plot!(kGrid, pdf.(Kolmogorov(),kGrid), 
	c=:red, label="Kolmogorov PDF", xlabel="K", ylabel="Density")

p2 = stephist(kStats2, bins=50, 
	c=:blue, label="KS stat (Normal)", normed=true)
p2 = plot!(kGrid, pdf.(Kolmogorov(),kGrid), 
	c=:red, label="Kolmogorov PDF", xlabel="K", ylabel="Density")

plot(p1, p2, xlims=(0,2.5), ylims=(0,1.8), size=(800, 400))