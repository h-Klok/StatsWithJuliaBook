using Distributions, Plots, LaTeXStrings; pyplot()

mu, sig = 2, 3
eta = sqrt(3)*sig/pi
n, N = 15, 10^4
dNormal   = Normal(mu, sig)
dLogistic = Logistic(mu, eta)
alphaUsed = 0.001:0.001:0.1

function alphaSimulator(dist, n, alpha)
    popVar        = var(dist)
    coverageCount = 0
    for _ in 1:N
        sVar = var(rand(dist, n))
        L = (n - 1) * sVar / quantile(Chisq(n-1),1-alpha/2)
        U = (n - 1) * sVar / quantile(Chisq(n-1),alpha/2)
        coverageCount +=  L < popVar && popVar < U
    end
    1 - coverageCount/N
end

scatter(alphaUsed, alphaSimulator.(dNormal,n,alphaUsed), 
	c=:blue, msw=0, label="Normal")
scatter!(alphaUsed, alphaSimulator.(dLogistic, n, alphaUsed), 
	c=:red, msw=0, label="Logistic")
plot!([0,0.1],[0,0.1],c=:black, label="1:1 slope", 
	xlabel=L"\alpha"*" used", ylabel=L"\alpha"*" actual", 
	legend=:topleft, xlim=(0,0.1), ylims=(0,0.2))