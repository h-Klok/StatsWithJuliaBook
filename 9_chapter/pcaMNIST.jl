using MultivariateStats, RDatasets, LinearAlgebra, Flux.Data.MNIST, Plots

imgs, labels   = MNIST.images(), MNIST.labels()
x = hcat([vcat(float.(im)...) for im in imgs]...)
pca = fit(PCA, x; maxoutdim=2)
M = projection(pca)

function compareDigits(dA,dB)
    imA, imB = imgs[labels .== dA], imgs[labels .== dB]
    xA = hcat([vcat(float.(im)...) for im in imA]...)
    xB = hcat([vcat(float.(im)...) for im in imB]...)
    zA, zB = M'*xA, M'*xB
    plot(zA[1,:],zA[2,:], c=:red, ms=0.5, msw=0, label="Digit $(dA)")
    plot!(zB[1,:],zB[2,:], c=:blue, ms=0.5, label="Digit $(dB)", xlims=(-5,12.5), ylims=(-7.5,7.5))
end

fig = figure(figsize = (15,10))
for k in 1:5
    aFig = fig.add_subplot(2,3,k)
    aFig.set_aspect("equal")
    compareDigits(2k-2,2k-1)
end