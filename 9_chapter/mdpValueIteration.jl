using LinearAlgebra, LaTeXStrings, Plots; pyplot()

L = 10
p0, p1 = 1/2, 3/4
beta = 0.75
epsilon = 0.001

function valueIteration(kappa)
    P0 = diagm(1=>fill(p0,L-1)) + diagm(-1=>fill(1-p0,L-1))
    P0[1,1], P0[L,L] = 1 - p0, p0

    P1 = diagm(1=>fill(p1,L-1)) + diagm(-1=>fill(1-p1,L-1))
    P1[1,1], P1[L,L] = 1 - p1, p1

    R0 = collect(1:L)
    R1 = R0 .- kappa

    bellmanOperator(Vprev)=
        max.(R0 + beta*P0*Vprev, R1 + beta*P1*Vprev)
    optimalPolicy(V,state)=
        (R0+beta*P0*V)[state] >= (R1+beta*P1*V)[state] ? 0 : 1

    V, Vprev = fill(0,L), fill(1,L)
    while norm(V-Vprev) > epsilon
        Vprev = V
        V = bellmanOperator(Vprev)
    end

    return [optimalPolicy(V,s) for s in 1:L]
end

kappaGrid = 0:0.1:2.0
policyMap = zeros(L,length(kappaGrid))

for (i,kappa) in enumerate(kappaGrid)
    policyMap[:,i] = valueIteration(kappa)
end
heatmap(policyMap, fill=cgrad([:blue, :red]), 
        xticks=(0:1:21, -0.1:0.1:2), yticks=(0:L, 0:L), 
        xlabel=L"\kappa", ylabel="State", colorbar_entry=false)