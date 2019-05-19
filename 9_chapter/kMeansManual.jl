using RDatasets, PyPlot, Distributions, Random
Random.seed!(1)

k = 3

xclara = dataset("cluster", "xclara")
n,_ = size(xclara)
dataPoints = [convert(Array{Float64,1},xclara[i,:]) for i in 1:n]
shuffle!(dataPoints)

xMin,xMax = minimum(first.(dataPoints)),maximum(first.(dataPoints))
yMin,yMax = minimum(last.(dataPoints)),maximum(last.(dataPoints))

means = [[rand(Uniform(xMin,xMax)),rand(Uniform(yMin,yMax))]  for _ in 1:k]
labels = rand([1,k],n)
prevMeans = -means

while norm(prevMeans - means) > 0.001
    prevMeans = means
    labels = [findmin([norm(means[i]-x) for i in 1:k])[2]  for x in dataPoints]
    means = [sum(dataPoints[labels .== i])/sum(labels .==i) for i in 1:k]
end

cnts = [sum(labels .== i) for i in 1:k]

println("Counts of clusters (manual implementation): ", cnts)
