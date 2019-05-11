using Random, CSV, Distributions, PyPlot
Random.seed!(0)

sampleData = CSV.read("machine1.csv", header=false)[:,1]
n, N = length(sampleData), 10^6
alpha = 0.1

bootstrapSampleMeans = [mean(rand(sampleData, n)) for i in 1:N]
L = quantile(bootstrapSampleMeans, alpha/2)
U = quantile(bootstrapSampleMeans, 1-alpha/2)

plt.hist(bootstrapSampleMeans, 1000, color="blue",
    normed=true, histtype = "step", label="Sample \nmeans")
plot([L, L],[0,2],"k--", label="95% CI")
plot([U, U],[0,2],"k--")
xlim(52,54)
ylim(0,2)
legend(loc="upper right")
