using Random, Distributions, PyPlot
Random.seed!(0)

data = randn(10^2)
plt.hist(data, 8, ec="black", cumulative=true)
