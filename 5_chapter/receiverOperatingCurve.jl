using Distributions, StatsBase, PyPlot

mu0, mu1a, mu1b, mu1c, std = 15, 16, 18, 20, 2

dist0 = Normal(mu0,std)
dist1a = Normal(mu1a,std)
dist1b = Normal(mu1b,std)
dist1c = Normal(mu1c,std)

tauGrid = 5:0.1:25

falsePositive = ccdf(dist0,tauGrid)
truePositiveA = ccdf(dist1a,tauGrid)
truePositiveB = ccdf(dist1b,tauGrid)
truePositiveC = ccdf(dist1c,tauGrid)

figure("ROC",figsize=(6,6))
subplot(111)
plot([0,1],[0,1],"--k", label="H0 = H1 = 15")
plot(falsePositive, truePositiveA,"b", label=L"H1a: $\mu_1$ = 16")
plot(falsePositive, truePositiveB,"r", label=L"H1b: $\mu_1$ = 18")
plot(falsePositive, truePositiveC,"g", label=L"H1c: $\mu_1$ = 20")

PyPlot.legend()
xlim(0,1)
ylim(0,1)
xlabel(L"\alpha")
ylabel("Power")
