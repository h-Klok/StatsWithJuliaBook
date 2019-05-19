using RDatasets, PyPlot, Clustering, Random, LinearAlgebra
Random.seed!(1)

xclara = dataset("cluster", "xclara")
n,_ = size(xclara)
dataPoints = [convert(Array{Float64,1},xclara[i,:]) for i in 1:n]
shuffle!(dataPoints)
D = [norm(pt1 - pt2) for pt1 in dataPoints, pt2 in dataPoints]

result = hclust(D)
for K in 1:30
    clusters = cutree(result,k=K)
    println("K=$(K): ",[sum(clusters .== i) for i in 1:K])
end

cluster(ell,K) = (1:n)[cutree(result,k=K) .== ell]

C1,C2,C3 = cluster(1,30),cluster(2,30),cluster(3,30)
fig = figure(figsize=(5, 5))
plot( first.(dataPoints[C1]),last.(dataPoints[C1]),"b.")
plot( first.(dataPoints[C2]),last.(dataPoints[C2]),"r.")
plot( first.(dataPoints[C3]),last.(dataPoints[C3]),"g.")
for ell in 4:30
    clst = cluster(ell,30)
    plot( first.(dataPoints[clst]),last.(dataPoints[clst]),"mx")
end
