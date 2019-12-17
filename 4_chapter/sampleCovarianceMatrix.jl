using Statistics, StatsBase, LinearAlgebra, DataFrames, CSV
df = CSV.read("../data/3featureData.csv",header=false)
n, p = size(df)
println("Number of features: ", p)
println("Number of observations: ", n)
X = convert(Array{Float64,2},df)
println("Dimensions of data matrix: ", size(X))

xbarA = (1/n)*X'*ones(n)
xbarB = [mean(X[:,i]) for i in 1:p]
xbarC = sum(X,dims=1)/n
println("\nAlternative calculations of (sample) mean vector: ")
@show(xbarA), @show(xbarB), @show(xbarC)

Y = (I-ones(n,n)/n)*X
println("Y is the de-meaned data: ", mean(Y,dims=1))

covA = (X .- xbarA')'*(X .- xbarA')/(n-1)
covB = Y'*Y/(n-1)
covC = [cov(X[:,i], X[:,j]) for i in 1:p, j in 1:p]
covD = [cor(X[:,i], X[:,j])*std(X[:,i])*std(X[:,j]) for i in 1:p, j in 1:p]
covE = cov(X)
println("\nAlternative calculations of (sample) covariance matrix: ")
@show(covA), @show(covB), @show(covC), @show(covD), @show(covE)

ZmatA = [(X[i,j] - mean(X[:,j]))/std(X[:,j]) for i in 1:n, j in 1:p ]
ZmatB = hcat([zscore(X[:,j]) for j in 1:p]...)
println("\nAlternate computation of Z-scores yields same matrix: ", 
	maximum(norm(ZmatA-ZmatB)))
Z = ZmatA

corA = covA ./ [std(X[:,i])*std(X[:,j]) for i in 1:p, j in 1:p]
corB = covA ./ (std(X,dims = 1)'*std(X,dims = 1))
corC = [cor(X[:,i],X[:,j]) for i in 1:p, j in 1:p]
corD = Z'*Z/(n-1)
corE = cov(Z)
corF = cor(X)
println("\nAlternative calculations of (sample) correlation matrix: ")
@show(corA), @show(corB), @show(corC), @show(corD), @show(corE), @show(corF);
