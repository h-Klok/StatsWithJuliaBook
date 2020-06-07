using Random, Distributions, StatsBase, Plots; pyplot()
Random.seed!(0)

x    = 0.1:0.1:10
y    = rand(Normal(),100) + sin.(2pi*x)
lags = collect(0:50)
atc  = autocor(y, lags)

p1 = plot(x, y, c=:blue, ls=:dash, m=(:dot, 5, Plots.stroke(0)), label="Regular data" )
p2 = plot(lags, atc, c=:red, ls=:dash, m=(:dot, 5, Plots.stroke(0)), label="Autocorrelation data")

plot(p1, p2, size=(800,400), legend=:topright)