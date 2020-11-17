using RDatasets, Distributions, Random, LinearAlgebra
Random.seed!(0)

K = 3
df = dataset("cluster", "xclara")
n,_ = size(df)
dataPoints = [convert(Array{Float64,1},df[i,:]) for i in 1:n]
shuffle!(dataPoints)

xMin,xMax = minimum(first.(dataPoints)),maximum(first.(dataPoints))
yMin,yMax = minimum(last.(dataPoints)),maximum(last.(dataPoints))

means = [[rand(Uniform(xMin,xMax)),rand(Uniform(yMin,yMax))]  for _ in 1:K]
labels = rand(1:K,n)
prevMeans = -means

while norm(prevMeans - means) > 0.001
    prevMeans = means
    labels = [argmin([norm(means[i]-x) for i in 1:K]) for x in dataPoints]
    means = [sum(dataPoints[labels .== i])/sum(labels .==i) for i in 1:K]
end

countResult = [sum(labels .== i) for i in 1:K]
println("Counts of clusters (manual implementation): ", countResult)