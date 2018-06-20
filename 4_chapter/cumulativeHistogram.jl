using Distributions, PyPlot

srand(1)
data = randn(10^2)
plt[:hist](data, 5, color="blue", ec="black", cumulative=true)
