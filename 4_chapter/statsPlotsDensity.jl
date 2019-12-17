using Random, Distributions, StatsPlots; pyplot()
Random.seed!(0)

mu1, sigma1 = 10, 5
mu2, sigma2 = 40, 12
dist1, dist2 = Normal(mu1,sigma1), Normal(mu2,sigma2)
p = 0.3
mixRv() = (rand() <= p) ? rand(dist1) : rand(dist2)

n = 2000
data = [mixRv() for _ in 1:n]

density(data, c=:blue, label="Density via StatsPlots", 
        xlims=(-20,80), ylims=(0,0.035))
stephist!(data, bins=50, c=:black, norm=true, 
    label="Histogram", xlabel="x", ylabel = "Density")