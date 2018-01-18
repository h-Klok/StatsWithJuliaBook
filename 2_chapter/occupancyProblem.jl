using StatsBase

function occupancyAnalytic(r::Int,n::Int)
    for m in 0:n-1
        println("Analytic P(", m, " empty buckets) = ",
        binomial(n,m)*sum([(-1)^v * binomial(n-m,v) * (1 - (m + v)/n)^r
                            for v in 0:(n-m)]) )
    end
end

function occupancyMC(r::Int,n::Int,s::Int)
    emptyCount = zeros(Int,n)
    buckets = collect(1:n)
    for i in 1:s
        bN = rand(buckets,r) # bucket no. for each ball
        nB = counts(bN,1:n) # how many balls in each bucket
        bE = counts(nB,0:0) # count how many buckets are empty
        emptyCount[bE+1] += 1
    end
    for m in 0:n-1
        println("MC simulated P(", m, " empty buckets) = ", emptyCount[m+1]/s)
    end
end

r = 18     # balls
n = 10     # buckets
s = 10^6   # number of simulations
occupancyAnalytic(r,n)
occupancyMC(r,n,s)
