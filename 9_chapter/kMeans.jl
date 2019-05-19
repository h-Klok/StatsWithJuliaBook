using Clustering, RDatasets, PyPlot

df = dataset("cluster", "xclara")
data = copy(convert(Array{Float64}, df)')

seeds = initseeds(:rand, data, 3)
xclara_kmeans = kmeans(data, 3)

println("Number of clusters: ", nclusters(xclara_kmeans))
println("Counts of clusters: ", counts(xclara_kmeans))

df.Group  = assignments(xclara_kmeans)

fig = figure(figsize=(10, 5))
subplot(121)
plot(df[:, :V1], df[:, :V2],"b.")
plot(df[seeds, :V1], df[seeds, :V2], markersize=12,"r.",)

subplot(122)
plot( df[df.Group .== 1, :V1], df[df.Group .== 1, :V2], "b.")
plot( df[df.Group .== 2, :V1], df[df.Group .== 2, :V2], "r.")
plot( df[df.Group .== 3, :V1], df[df.Group .== 3, :V2], "g.")
