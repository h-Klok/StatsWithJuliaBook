using CSV, GLM, StatsBase, Random, Distributions, Plots, Measures; pyplot()
Random.seed!(0)

n, N = 10^3, 10^6

function waldWolfowitz(data)
    n = length(data)
    sgns = data .>= mean(data);
    nPlus, nMinus = sum(sgns), n - sum(sgns)
    wwMu = 2*nPlus*nMinus/n + 1
    wwVar = (wwMu-1)*(wwMu-2)/(n-1)

    R = 1
    for i in 1:n-1
        R += sgns[i] != sgns[i+1]
    end

    zStat = abs((R-wwMu)/sqrt(wwVar))
    2*ccdf(Normal(),zStat)
end

experimentPvals = [waldWolfowitz(rand(Normal(),n)) for _ in 1:N]
for alpha in [ 0.001, 0.005, 0.01, 0.05, 0.1]
    pva = sum(experimentPvals .< alpha)/N
    println("For alpha = $(alpha), p-value area = $(pva)")
end

p1 = histogram(experimentPvals,bins = 5n, legend = false,
    xlabel = "p-value", ylabel = "Frequency")

Fhat = ecdf(experimentPvals)

pGrid = 0:0.001:1
p2 = plot(pGrid,Fhat.(pGrid), legend =false, xlabel = "p-value", ylabel = "ECDF")
plot(p1, p2, size = (1000,400), margin = 5mm)
