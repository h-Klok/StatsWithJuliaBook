using Distributions, PyPlot

include("mvParams.jl")
biNorm = MvNormal(meanVect,covMat)

N = 10^3
points = rand(MvNormal(meanVect,covMat),N)

support = 15:0.1:40
Z = [ pdf(biNorm,[i,j]) for i in support, j in support ]

fig = figure(figsize=(10,5))
ax = fig.add_subplot(121)
plot(points[1,:], points[2,:], ".", ms=1, label="scatter")
CS = contour(support, support, copy(Z'), levels=[0.001, 0.005, 0.02])

ax = fig.add_subplot(122, projection = "3d")
plot_surface(support, support, Z, rstride=1, cstride=1, lw=0,
	antialiased=false, cmap="coolwarm",)
