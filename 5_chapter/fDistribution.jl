using Distributions, Plots; pyplot()

n1, n2 = 10, 15
N = 10^6
mu, sigma = 10, 4
normDist = Normal(mu,sigma)

fValues = Array{Float64}(undef, N)

for i in 1:N
    data1 = rand(normDist,n1)
    data2 = rand(normDist,n2)
    fValues[i] = var(data1)/var(data2)
end

fRange = 0:0.1:5
stephist(fValues, bins=400, c=:blue, label="Simulated", normed=true)
plot!(fRange, pdf.(FDist(n1-1, n2-1), fRange), 
	c=:red, label="Analytic", xlims=(0,5), ylims=(0,0.8),
    	xlabel = "F", ylabel = "Density")