using Random, CSV, Distributions, Plots; pyplot()
Random.seed!(0)

sampleData = CSV.read("../data/machine1.csv", header=false)[:,1]
n, N = length(sampleData), 10^6
alpha = 0.1

bootstrapSampleMeans = [mean(rand(sampleData, n)) for i in 1:N]
Lmean = quantile(bootstrapSampleMeans, alpha/2)
Umean = quantile(bootstrapSampleMeans, 1-alpha/2)

bootstrapSampleMedians = [median(rand(sampleData, n)) for i in 1:N]
Lmed = quantile(bootstrapSampleMedians, alpha/2)
Umed = quantile(bootstrapSampleMedians, 1-alpha/2)

println("Bootstrap confidence interval for the mean: ", (Lmean, Umean) )
println("Bootstrap confidence interval for the median: ", (Lmed, Umed) )

stephist(bootstrapSampleMeans, bins=1000, c=:blue,
    normed=true, label="Sample \nmeans")
plot!([Lmean, Lmean],[0,2], c=:black, ls=:dash, label="90% CI")
plot!([Umean, Umean],[0,2],c=:black, ls=:dash, label="",
    xlims=(52,54), ylims=(0,2), xlabel="Sample Means", ylabel="Density")