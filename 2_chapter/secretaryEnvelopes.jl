using Random, PyPlot, StatsBase, Combinatorics
Random.seed!(1)
function bruteSetsProbabilityAllMiss(n)
    omega = collect(permutations(1:n))
    matchEvents = []

    for i in 1:n
        event = []
        for p in omega
            if p[i] == i
                push!(event,p)
            end
        end
        push!(matchEvents,event)
    end

    noMatch = setdiff(omega,union(matchEvents...))
    return length(noMatch)/length(omega)
end

function formulaCalcAllMiss(n)
    return sum([(-1)^k/factorial(k) for k in 0:n])
end

function mcAllMiss(n,N)
    function envelopeStuffer()
        envelopes = Random.shuffle!(collect(1:n))
        return sum([envelopes[i] == i for i in 1:n]) == 0
    end

    data = [envelopeStuffer() for _ in 1:N]
    return sum(data)/N
end

N = 10^6

println("n\tBrute Force\tFormula\t\tMonte Carlo\t\tAnalytic",)
for n in 1:8
    bruteForce = bruteSetsProbabilityAllMiss(n)
    fromFormula = formulaCalcAllMiss(n)
    fromMC = mcAllMiss(n,N)
    println(n,"\t",round(bruteForce,digits=4),"\t\t",round(fromFormula,digits=4),
	"\t\t",round(fromMC,digits=4),"\t\t",round(1/MathConstants.e,digits=4))
end