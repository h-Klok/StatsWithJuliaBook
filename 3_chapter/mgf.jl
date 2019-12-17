using Distributions, Statistics, Plots; pyplot()

dist1 = TriangularDist(0,1,1)
dist2 = TriangularDist(0,1,0)
N=10^6

data1, data2 = rand(dist1,N), rand(dist2,N)
dataSum = data1 + data2

mgf(s) = 4(1+(s-1)*MathConstants.e^s)*(MathConstants.e^s-1-s)/s^4

mgfPointEst(s) = mean([MathConstants.e^(s*z) for z in 
					rand(dist1,20) + rand(dist2,20)])

p1 = histogram(dataSum, bins=80, normed=:true, 
	ylims=(0,1.4), xlabel="z", ylabel="PDF")

sGrid = -1:0.01:1
p2 = plot(sGrid, mgfPointEst.(sGrid), c=:blue, ylims=(0,3.5))
p2 = plot!(sGrid, mgf.(sGrid), c=:red)
p2 = plot!( [minimum(sGrid),maximum(sGrid)], 
	[minimum(sGrid),maximum(sGrid)].+1, 
	c=:black, xlabel="s", ylabel="MGF")

plot(p1, p2, legend=:none, size=(800, 400))