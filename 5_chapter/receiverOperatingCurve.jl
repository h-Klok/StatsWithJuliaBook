using Distributions, StatsBase, Plots, LaTeXStrings; pyplot()

mu0, mu1a, mu1b, mu1c, sd = 15, 16, 18, 20, 2
tauGrid = 5:0.1:25

dist0 = Normal(mu0,sd)
dist1a, dist1b, dist1c  = Normal(mu1a,sd), Normal(mu1b,sd), Normal(mu1c,sd)

falsePositive = ccdf.(dist0,tauGrid)
truePositiveA, truePositiveB, truePositiveC = 
    ccdf.(dist1a,tauGrid), ccdf.(dist1b,tauGrid), ccdf.(dist1c,tauGrid)

plot(falsePositive, [truePositiveA truePositiveB truePositiveC], 
    c=[:blue :red :green], 
    label=[L"H1a: \mu_1 = 16" L"H1b: \mu_1 = 18" L"H1c: \mu_1 = 20"])
plot!([0,1], [0,1], c=:black, ls=:dash, label="H0 = H1 = 15", 
    xlims=(0,1), ylims=(0,1), xlabel=L"\alpha", ylabel="Power", 
    ratio=:equal, legend=:bottomright)