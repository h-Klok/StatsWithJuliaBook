using Random, Distributions, KernelDensity, PyPlot
Random.seed!(1)

function pval(mu0,mu,sig,n)
    sample = rand(Normal(mu,sig),n)
    xBar   = mean(sample)
    s      = std(sample)
    tStat  = (xBar-mu0) / (s/sqrt(n))
    ccdf(TDist(n-1), tStat)
end

mu0, mu1  = 20, 22
sig, n, N = 7, 5, 10^6

pValsH0 = [pval(mu0,mu0,sig,n) for _ in 1:N]
pValsH1 = [pval(mu0,mu1,sig,n) for _ in 1:N]

plt.hist(pValsH0,100,normed="true", histtype="step",color="b",label="Under H0")
plt.hist(pValsH1,100,normed="true",histtype="step",color="r",label="Under H1")
xlim(0,1)
legend(loc="upper right")
