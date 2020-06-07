using Random, Distributions, KernelDensity, Plots, LaTeXStrings; pyplot()
Random.seed!(1)

function pval(mu0,mu,sig,n)
    sample = rand(Normal(mu,sig),n)
    xBar   = mean(sample)
    s      = std(sample)
    tStat  = (xBar-mu0) / (s/sqrt(n))
    ccdf(TDist(n-1), tStat)
end

mu0, mu1A, mu1B  = 20, 22, 24
sig, n, N = 7, 5, 10^6

pValsH0 = [pval(mu0,mu0,sig,n) for _ in 1:N]
pValsH1A = [pval(mu0,mu1A,sig,n) for _ in 1:N]
pValsH1B = [pval(mu0,mu1B,sig,n) for _ in 1:N]

alpha = 0.05
estPwr(pVals) = sum(pVals .< alpha)/N

println("Power under H0:  ", estPwr(pValsH0))
println("Power under H1A: ", estPwr(pValsH1A))
println("Power under H1B (mu's farther apart): ", estPwr(pValsH1B))

stephist(pValsH0, bins=100,
	normed=true, c=:blue, label="Under H0")
stephist!(pValsH1A, bins=100,
	normed=true, c=:red, label="Under H1A")
stephist!(pValsH1B, bins=100,
	normed=true, c=:green, label="Under H1B", 
    xlims=(0,1), ylims=(0,6), xlabel = "p-value", ylabel = "Density")

plot!([alpha,alpha],[0,6], 
	c=:black, ls=:dash, label=L"\alpha")