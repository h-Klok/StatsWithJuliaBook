using Distributions, PyPlot

L, K, n  = 500, [450, 400, 250, 100, 50], 30
hyperDists = [Hypergeometric(k,L-k,n) for k in K]
xGrid = 0:1:30

[bar(xGrid, pdf(hyperDists[i],xGrid), width=0.2, alpha=0.65,
    label="Failures = $(K[i])") for i in 1:length(K)]
legend()
xlabel("x")
ylabel("Probability")
