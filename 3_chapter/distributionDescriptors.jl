using Distributions
tDist = TriangularDist(0,2,1)

println("Parameters: \t\t\t",params(tDist))
println("Central descriptors: \t\t",mean(tDist),"\t",median(tDist))
println("Dispersion descriptors: \t", var(tDist),"\t",std(tDist))
println("Higher moment shape descriptors: ",skewness(tDist),"\t",kurtosis(tDist))
println("Range: \t\t\t\t", minimum(tDist),"\t",maximum(tDist))
println("Mode: \t\t\t\t", mode(tDist), "\tModes: ",modes(tDist))
