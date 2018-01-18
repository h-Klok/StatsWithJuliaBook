using Distributions, PyPlot

population, K = 500, [450, 400, 250, 100, 50]
hyperDists = [Hypergeometric(k,population-k,30) for k in K]
xGrid = 0:1:30

[bar(xGrid, pdf(hyperDists[i],xGrid), width=0.2, alpha=0.65, 
    label="Failures = $(K[i])") for i in 1:length(K)] 
legend()
xlabel("x")
ylabel(L"$\mathbb{P}(X=x)$")
savefig("ypergeometricPDFs.png")
