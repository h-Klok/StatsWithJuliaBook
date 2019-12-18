using Distributions, Random, Plots; pyplot()
Random.seed!(0)

n, N, alpha = 3, 10^7, 0.1

myT(nObs) = rand(Normal())/sqrt(rand(Chisq(nObs-1))/(nObs-1))
mcQuantile = quantile([myT(n) for _ in 1:N],alpha)
analyticQuantile = quantile(TDist(n-1),alpha)

println("Quantile from Monte Carlo: ", mcQuantile)
println("Analytic qunatile: ", analyticQuantile)

xGrid = -5:0.1:5
plot(xGrid, pdf.(Normal(), xGrid), c=:black, label="Normal Distribution")
scatter!(xGrid, pdf.(TDist(1) ,xGrid), 
	c=:blue, msw=0, label="DOF = 1")
scatter!(xGrid, pdf.(TDist(3), xGrid), 
	c=:red, msw=0, label="DOF = 3")
scatter!(xGrid, pdf.(TDist(100),xGrid), 
	c=:green, msw=0, label="DOF = 100", 
	xlims=(-4,4), ylims=(0,0.5), xlabel="X", ylabel="Density")