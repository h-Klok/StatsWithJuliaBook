using LinearAlgebra, StatsBase, Random, LaTeXStrings, Plots; pyplot()
Random.seed!(0)

L = 10
p0, p1 = 1/2, 3/4
beta = 0.75
pExplore(t) = t^-0.2
alpha(t) = t^-0.2
T = 10^6

function QlearnSim(kappa)
    P0 = diagm(1=>fill(p0,L-1)) + diagm(-1=>fill(1-p0,L-1))
    P0[1,1], P0[L,L] = 1 - p0, p0

    P1 = diagm(1=>fill(p1,L-1)) + diagm(-1=>fill(1-p1,L-1))
    P1[1,1], P1[L,L] = 1 - p1, p1

    R0 = collect(1:L)
    R1 = R0 .- kappa

    nextState(s,a) =
    	a == 0 ? sample(1:L,weights(P0[s,:])) : sample(1:L,weights(P1[s,:]))

    Q = zeros(L,2)
    s = 1
    optimalAction(s) = Q[s,1] >= Q[s,2] ? 0 : 1
    for t in 1:T
        if rand() < pExplore(t)
            a = rand([0,1])
        else
            a = optimalAction(s)
        end
        sNew = nextState(s,a)
        r = a == 0 ? R0[sNew] : R1[sNew]
        Q[s,a+1]=(1-alpha(t))*Q[s,a+1]+alpha(t)*(r+beta*max(Q[sNew,1],Q[sNew,2]))
        s = sNew
    end
    [optimalAction(s) for s in 1:L]
end

kappaGrid = 0.0:0.1:2.0
policyMap = zeros(L,length(kappaGrid))

for (i,kappa) in enumerate(kappaGrid)
    policyMap[:,i] = QlearnSim(kappa)
end

heatmap(policyMap, fill=cgrad([:blue, :red]), 
        xticks=(0:1:21, -0.1:0.1:2), yticks=(0:L, 0:L), 
        xlabel=L"\kappa", ylabel="State", colorbar_entry=false)