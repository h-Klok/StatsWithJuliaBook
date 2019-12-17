using Distributions
dist = TriangularDist(0,2,1)

println("Parameters: \t\t\t",params(dist))
println("Central descriptors: \t\t",mean(dist),"\t",median(dist))
println("Dispersion descriptors: \t", var(dist),"\t",std(dist))
println("Higher moment shape descriptors: ",skewness(dist),"\t",kurtosis(dist))
println("Range: \t\t\t\t", minimum(dist),"\t",maximum(dist))
println("Mode: \t\t\t\t", mode(dist), "\tModes: ",modes(dist))