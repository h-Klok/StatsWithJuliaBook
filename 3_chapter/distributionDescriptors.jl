using Distributions
tDist = TriangularDist(0,2,1)

println("Parameters: ",params(tDist))
println("Central descriptors: ",mean(tDist),"\t",median(tDist))
println("Dispersion descriptors: ", var(tDist),"\t",std(tDist))
println("Higher moment shape descriptors: ",skewness(tDist),"\t",kurtosis(tDist))
println("Range: ", minimum(tDist),"\t",maximum(tDist))
println("Mode: ", mode(tDist), "\tModes: ",modes(tDist))