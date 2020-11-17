using RDatasets, DataFrames, Random, Statistics, LinearAlgebra
using MultivariateStats, LaTeXStrings, Plots; pyplot()
Random.seed!(0)

df = dataset("MASS", "cpus")
n = size(df)[1]
df = df[shuffle(1:n),:]

K = 10
nG = Int(floor(n/K))
n = K*nG
println("Losing $(size(df)[1] - n) observations.")

lamGrid = 0:100:30000

devSet(k) = collect(1+nG*(k-1):nG*k)
trainSet(k) = setdiff(1:n,devSet(k))

xTrain(k) = convert(Array{Float64,2},df[trainSet(k),[:Cach, :ChMin]])
xDev(k) = convert(Array{Float64,2},df[devSet(k),[ :Cach, :ChMin]])

yTrain(k) = convert(Array{Float64,1},df[trainSet(k),:Perf])
yDev(k) = convert(Array{Float64,1},df[devSet(k),:Perf])

errVals = zeros(length(lamGrid))
for (i,lam) in enumerate(lamGrid)
    errSamples = zeros(K)
    for k in 1:K
        beta = ridge(xTrain(k),yTrain(k),lam)
        errSamples[k] = norm([ones(nG) xDev(k)]*beta - yDev(k) )^2
    end
    errVals[i] = sqrt(mean(errSamples))
end

i = argmin(errVals)
bestLambda = lamGrid[i]

betaFinal = ridge(convert(Array{Float64,2},df[:,[:Cach, :ChMin]]),
                  convert(Array{Float64,1},df[:,:Perf]),bestLambda)

macro RR(x) return:(round.($x,digits = 3)) end
println("Found best lambda for regularization: ", bestLambda)
println("Beta estimate: ", @RR betaFinal)

plot(lamGrid, errVals,legend = false,
     xlabel = L"\lambda", ylabel = "Loss")
plot!([bestLambda,bestLambda],[0,10^3], c = :black, ylim = (750, 1250))