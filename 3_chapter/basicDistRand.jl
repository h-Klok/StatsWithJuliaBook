using Distributions, StatsBase, Random
Random.seed!(1)

dist1 = TriangularDist(0,10,5)
dist2 = DiscreteUniform(1,5)
theorMean1, theorMean2 = mean(dist1), mean(dist2)

N = 10^6
data1 = rand(dist1,N)
data2 = rand(dist2,N)
estMean1, estMean2 = mean(data1), mean(data2)

println("Symmetric Triangular Distiribution on [0,10] has mean $theorMean1
	(estimated: $estMean1)")
println("Discrete Uniform Distiribution on {1,2,3,4,5} has mean $theorMean2
	(estimated: $estMean2)")