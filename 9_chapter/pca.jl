using Statistics, MultivariateStats, RDatasets, LinearAlgebra, Plots; pyplot()

data = dataset("datasets", "iris")
data = data[:,[:SepalLength,:SepalWidth,:PetalLength,:PetalWidth]]
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

p1 = plot(pcVar, c=:blue, label="Variance due to PC")
	plot!(1:length(cumVar), cumVar, label="Cumulative Variance", c=:red, 
        xlabel="Principle component",ylabel="Variance Proportion",ylims=(0,1))
p2 = scatter(pcDat[1,:],pcDat[2,:], c=:blue, xlabel="PC 1", ylabel="PC 2",
            msw=0, legend=:none)
plot(p1, p2, size=(800,400))