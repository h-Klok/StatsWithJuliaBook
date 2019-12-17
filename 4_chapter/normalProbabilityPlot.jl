using Random, Distributions, StatsPlots, Plots; pyplot()
Random.seed!(0)
 
mu = 20
d1, d2 = Normal(mu,mu), Exponential(mu)
 
n = 100
data1 = rand(d1,n)
data2 = rand(d2,n)
 
qqnorm(data1, c=:blue, ms=3, msw=0, label="Normal Data")
qqnorm!(data2, c=:red, ms=3, msw=0, label="Exponential Data",
        xlabel="Normal Theoretical Quantiles",
        ylabel="Data Quantiles", legend=true)