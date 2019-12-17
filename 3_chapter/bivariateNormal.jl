using Distributions, Plots; pyplot()

include("../data/mvParams.jl")
biNorm = MvNormal(meanVect,covMat)

N = 10^3
points = rand(MvNormal(meanVect,covMat),N)

support = 15:0.5:40
z = [ pdf(biNorm,[x,y]) for y in support, x in support ]

p1 = scatter(points[1,:], points[2,:], ms=0.5, c=:black, legend=:none)
p1 = contour!(support, support, z, 
		levels=[0.001, 0.005, 0.02], c=[:blue, :red, :green], 
		xlims=(15,40), ylims=(15,40), ratio=:equal, legend=:none, 
		xlabel="x", ylabel="y")
p2 = surface(support, support, z, lw=0.1, c=cgrad([:blue, :red]),
		 legend=:none, xlabel="x", ylabel="y",camera=(-35,20))

plot(p1, p2, size=(800, 400))