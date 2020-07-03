using RDatasets, Clustering, Random, LinearAlgebra, Plots; pyplot()
Random.seed!(0)

df = dataset("cluster", "xclara")
n,_ = size(df)
dataPoints = [convert(Array{Float64,1},df[i,:]) for i in 1:n]
shuffle!(dataPoints)
D = [norm(pt1 - pt2) for pt1 in dataPoints, pt2 in dataPoints]

result = hclust(D)
for K in 1:30
    clusters = cutree(result,k=K)
    println("K=$(K): ",[sum(clusters .== i) for i in 1:K])
end

cluster(ell,K) = (1:n)[cutree(result,k=K) .== ell]

C1, C2, C3 = cluster(1,30),cluster(2,30),cluster(3,30)

plt = scatter( first.(dataPoints[C1]),last.(dataPoints[C1]),c=:blue, msw=0)
      scatter!( first.(dataPoints[C2]),last.(dataPoints[C2]), c=:red, msw=0)
      scatter!( first.(dataPoints[C3]),last.(dataPoints[C3]), c=:green, msw=0)
for ell in 4:30
    clst = cluster(ell,30)
    scatter!(first.(dataPoints[clst]),last.(dataPoints[clst]), 
        ms=10, c=:purple, shape=:xcross, ratio=:equal, legend=:none,
        xlabel="V1", ylabel="V2")
end
plot(plt)