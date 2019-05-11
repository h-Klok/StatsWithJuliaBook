using Statistics, MultivariateStats, RDatasets, PyPlot, LinearAlgebra

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

figure(figsize=(10,5))
subplot(121)
plot( 1:length(pcVar) , pcVar,"bo-", label="Variance due to PC")
plot( 1:length(cumVar) , cumVar,"ro-", label="Cumulative Variance")
legend(loc="center right")
ylim(-0.1,1.1)

subplot(122)
plot(pcDat[1,:],pcDat[2,:],".")
xlabel("PC 1");ylabel("PC 2")
