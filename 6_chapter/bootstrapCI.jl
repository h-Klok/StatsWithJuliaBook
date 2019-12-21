using Random, Distributions
Random.seed!(0)

lambda = 0.1
dist = Exponential(1/lambda)
actualMedian = median(dist)

M = 10^3
N = 10^4
nRange = 2:2:10
alpha = 0.05

for n in nRange
    coverageCount = 0
    for _ in 1:M
        sampleData = rand(dist, n)
        bootstrapSampleMeans = [median(rand(sampleData, n)) for _ in 1:N]
        L = quantile(bootstrapSampleMeans, alpha/2)
        U = quantile(bootstrapSampleMeans, 1-alpha/2)
        coverageCount += L < actualMedian && actualMedian < U
    end
    println("n = ",n,"\t coverage = ", coverageCount/M)
end