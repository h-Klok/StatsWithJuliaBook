using PyPlot, LinearAlgebra, Random

function adjMatrix(edges)
    L = maximum(vcat(edges...))
    aM = zeros(Int, L, L)
    for e in edges
        aM[ e[1], e[2] ], aM[ e[2], e[1] ] = 1, 1
    end
    aM
end

function pathExists(adjMatrix, source, destination)
    L = size(adjMatrix)[1]
    adjMatrix += I
    sign.(adjMatrix^L)[source,destination]
end

edges = [[1,2],[1,3],[2,4],[1,4],[3,4]]
source, dest = 1, 4

N = 10^5
L = maximum(vcat(edges...))
adjMat = adjMatrix(edges)
randNet(p) = adjMat.*(rand(L,L) .<= 1-p)
relEst(p) = sum( [pathExists(randNet(p), source, dest) for _ in 1:N] )/N

relAnalytic(p) = 1-p^3*(p-2)^2

Random.seed!(1)
pGrid = 0:0.02:1
plot(pGrid, relEst.(pGrid),"b.",label="MC")
plot(pGrid, relAnalytic.(pGrid),"r",label="Analytic")
xlim(0,1)
ylim(0,1)
xlabel("p")
ylabel("Reliability")
legend(loc="upper right")
