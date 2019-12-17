using Distributions, Plots; pyplot()

dist = TriangularDist(4,6,5)
N = 10^6
data = rand(dist,N)
yData=(data .- 5).^2

println("Mean: ", mean(yData), " Variance: ", var(data))

p1 = histogram(data, xlabel="x", bins=80, normed=true, ylims=(0,1.1))
p2 = histogram(yData, xlabel="y", bins=80, normed=true, ylims=(0,15))
plot(p1, p2, ylabel="Proportion", size=(800, 400), legend=:none)