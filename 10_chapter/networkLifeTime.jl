using LightGraphs, Distributions, StatsBase, Random, Plots, LaTeXStrings;pyplot()
Random.seed!(0)

function createNetwork(edges)
    network = Graph(maximum(maximum.(edges)))
    for e in edges
        add_edge!(network, e[1], e[2])
    end
    network
end

function uniformRandomEdge(network)
    outDegrees = length.(network.fadjlist)
    randI = sample(1:length(outDegrees),Weights(outDegrees))
    randJ = rand(network.fadjlist[randI])
    randI, randJ
end

function networkLife(network,source,dest,lambda)
    failureNetwork = copy(network)
    t = 0
    while has_path(failureNetwork, source, dest)
        t += rand(Exponential(1/(failureNetwork.ne*lambda)))
        i, j = uniformRandomEdge(failureNetwork)
        rem_edge!(failureNetwork, i, j)
    end
    t
end

lambda1, lambda2 = 0.5, 1.0
roads = [(1,2), (1,3), (2,4), (2,5), (2,3), (3,4), (3,5), (4,5), (4,6), (5,6)]
source, dest = 1, 6
network = createNetwork(roads)
N = 10^6

failTimes1 = [ networkLife(network,source,dest,lambda1) for _ in 1:N ]
failTimes2 = [ networkLife(network,source,dest,lambda2) for _ in 1:N ]

println("Edge Failure Rate = $(lambda1): Mean failure time = ",
	mean(failTimes1), " days.")
println("Edge Failure Rate = $(lambda2): Mean failure time = ",
	mean(failTimes2), " days.")

stephist(failTimes1, bins=200, c=:blue, normed=true, label=L"\lambda=0.5")
stephist!(failTimes2, bins=200, c=:red, normed=true, label=L"\lambda=1.0", 
    xlims=(0,5), ylims=(0,1.1), xlabel="Network Life Time", ylabel = "Density")