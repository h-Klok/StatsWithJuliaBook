using Random, Distributions, Plots; pyplot()
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

println("Actual mean: ",mean(expDist),
		"\nMean of sample means: ",mean(means))
println("Actual variance: ",var(expDist),
	"\nMean of sample variances: ",mean(variances))

stephist(means, bins=200, c=:blue, normed=true, 
	label="Histogram of Sample Means")
stephist!(variances, bins=600, c=:red, normed=true, 
	label="Histogram of Sample Variances", xlims=(0,40), ylims=(0,0.4),
    	xlabel = "Statistic value", ylabel = "Density")