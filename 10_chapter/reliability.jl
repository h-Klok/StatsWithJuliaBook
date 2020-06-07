using LinearAlgebra, Random, Plots; pyplot()
Random.seed!(1)

N = 10^4
edges = [(1,2), (1,3), (2,4), (1,4), (3,4)]
L = maximum(maximum.(edges))
source, dest = 1, L

function adjMatrix(edges,L)
    R = zeros(Int, L, L)
    for e in edges
        R[ e[1], e[2] ], R[ e[2], e[1] ] = 1, 1
    end
    R
end

pathExists(R, source, destination) = sign.((I+R)^L)[source,destination]
randNet(p) = randsubseq(edges,1-p)

relEst(p) = sum([pathExists(adjMatrix(randNet(p),L),source,dest) for _ in 1:N])/N
relAnalytic(p) = 1-p^3*(p-2)^2

pGrid = 0:0.05:1
scatter(pGrid, relEst.(pGrid),
	c=:blue, ms=5, msw=0,label="Monte Carlo")
plot!(pGrid, relAnalytic.(pGrid),
	c=:red, label="Analytic", xlims=(0,1.05), ylims=(0,1.05), 
	xlabel="p", ylabel="Reliability")