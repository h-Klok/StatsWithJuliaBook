using Random, Distributions, PyPlot
Random.seed!(0)

lambda  = 1/4.5
expDist = Exponential(1/lambda)
n, N    = 10, 10^6

means     = Array{Float64}(undef, N)
variances = Array{Float64}(undef, N)

for i in 1:N
    data = rand(expDist,n)
    means[i] = mean(data)
    variances[i] = var(data)
end

plt.hist(means,200, color="b", label = "Histogram of Sample Means",
			histtype = "step", density = true)
plt.hist(variances,600, color="r", label = "Histogram of Sample Variances",
			histtype = "step", density = true)
xlim(0,40)
legend(loc="upper right")
println("Actual mean: ",mean(expDist),
		"\nMean of sample means: ",mean(means))
println("Actual variance: ",var(expDist),
	"\nMean of sample variances: ",mean(variances))
