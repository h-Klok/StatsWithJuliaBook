using Statistics, MultivariateStats, RDatasets, LinearAlgebra, Plots; pyplot()

data = dataset("datasets", "iris")
data = data[[:SepalLength,:SepalWidth,:PetalLength,:PetalWidth]]
n = size(data)[1]
x = convert(Array{Float64,2},data)'

model = fit(PCA, x, maxoutdim=4, pratio = 0.999)
M = projection(model)

function manualProjection(x)
    covMat = cov(x')
    ev = eigvals(covMat)
    eigOrder = sortperm(eigvals(covMat),rev=true)
    eigvecs(covMat)[:,eigOrder]
end

println("Manual vs. package: ",maximum(abs.(M-manualProjection(x))))

pcVar = principalvars(model) ./ tvar(model)
cumVar = cumsum(pcVar)

pcDat = M[:,1:2]'*x

p1 = plot( pcVar, c=:blue, label="Variance due to PC", ylims=(0,1))
p1 = plot!( 1:length(cumVar) , cumVar, c=:red, xlabel="Principle component", label="Cumulative Variance")

p2 = scatter(pcDat[1,:],pcDat[2,:], c=:blue, msw=0, xlabel="PC 1", ylabel="PC 2", legend=:none)

plot(p1, p2, size=(800,400))
