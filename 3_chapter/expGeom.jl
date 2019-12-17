using StatsBase, Distributions, Plots; pyplot()

lambda, N = 1, 10^6
xGrid = 0:6

expDist = Exponential(1/lambda)
floorData = counts(convert.(Int,floor.(rand(expDist,N))), xGrid)/N
geomDist = Geometric(1-MathConstants.e^-lambda)

plot( xGrid, floorData, 
	line=:stem, marker=:circle, 
	c=:blue, ms=10, msw=0, lw=4, 
	label="Floor of Exponential")
plot!( xGrid, pdf.(geomDist,xGrid), 
	line=:stem, marker=:xcross, 
	c=:red, ms=6, msw=0, lw=2, 
	label="Geometric", ylims=(0,1), 
	xlabel="x", ylabel="Probability")