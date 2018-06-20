using Distributions, PyPlot
srand(1)

lambda = 1/4.5 
expDist = Exponential(1/lambda)
n, N = 10, 10^6

means = Array{Float64}(N)
variances = Array{Float64}(N)

for i in 1:N
    data = rand(expDist,n)
    means[i] = mean(data)
    variances[i] = var(data)
end

plt[:hist](means,200, color="b", label = "Histogram of Sample Means",
			histtype = "step", normed = true)
plt[:hist](variances,600, color="r", label = "Histogram of Sample Variances",
			histtype = "step", normed = true)
xlim(0,40)
legend(loc="upper right")
println("Actual mean: ",mean(expDist),"\nMean of means: ",mean(means))
println("Actual variance: ",var(expDist),"\nMean of variances: ",mean(variances))
