using Random, Distributions, KernelDensity, Plots, LaTeXStrings; pyplot()
Random.seed!(1)

function tStat(mu0,mu,sig,n)
    sample = rand(Normal(mu,sig),n)
    xBar   = mean(sample)
    s      = std(sample)
    (xBar-mu0)/(s/sqrt(n))
end

mu0, mu1A, mu1B = 20, 22, 24
sig, n = 7, 5
N = 10^6
alpha = 0.05

dataH0  = [tStat(mu0,mu0,sig,n) for _ in 1:N]
dataH1A = [tStat(mu0,mu1A,sig,n) for _ in 1:N]
dataH1B = [tStat(mu0,mu1B,sig,n) for _ in 1:N]
dataH1C = [tStat(mu0,mu1B,sig,2*n) for _ in 1:N]
dataH1D = [tStat(mu0,mu1B,sig/2,2*n) for _ in 1:N]

tCrit = quantile(TDist(n-1),1-alpha)
estPwr(sample) = sum(sample .> tCrit)/N

println("Rejection boundary: ", tCrit)
println("Power under H0:  ", estPwr(dataH0))
println("Power under H1A: ", estPwr(dataH1A))
println("Power under H1B (mu's farther apart): ", estPwr(dataH1B))
println("Power under H1C (double sample size): ", estPwr(dataH1C))
println("Power under H1D (like H1C but std/2): ", estPwr(dataH1D))

kH0  = kde(dataH0)
kH1A = kde(dataH1A)
kH1D = kde(dataH1D)
xGrid = -10:0.1:15

plot(xGrid,pdf(kH0,xGrid),
	c=:blue, label="Distribution under H0")
plot!(xGrid,pdf(kH1A,xGrid),
	c=:red, label="Distribution under H1A")
plot!(xGrid,pdf(kH1D,xGrid),
	c=:green, label="Distribution under H1D")
plot!([tCrit,tCrit],[0,0.4], 
	c=:black, ls=:dash, label="Critical value boundary", 
	xlims=(-5,10), ylims=(0,0.4), xlabel=L"\Delta = \mu - \mu_0")