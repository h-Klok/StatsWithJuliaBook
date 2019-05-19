using Random, Distributions
Random.seed!(0)

M = 1000
N = 10^4
nRange = 5:5:50
alpha = 0.1

for n in nRange
    coverageCount = 0
    for i in 1:M
        sampleData = rand(Exponential(10), n)
        bootstrapSampleMeans = [mean(rand(sampleData, n)) for _ in 1:N]
        L = quantile(bootstrapSampleMeans, alpha/2)
        U = quantile(bootstrapSampleMeans, 1-alpha/2)
        coverageCount += L < 10 && 10 < U
    end
    println("n = ",n,"\t coverage = ", coverageCount/M)
end
