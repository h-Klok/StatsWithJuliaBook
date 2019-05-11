using PyPlot

function occupancyAnalytic(n,r)
    return sum([(-1)^k * binomial(n,k) * (1 - k/n)^r for k in 0:n])
end

function occupancyMC(n,r,N)
    fullCount = 0
    for _ in 1:N
        envelopes = zeros(Int,n)
        for k in 1:r
            target = rand(1:n)
            envelopes[target] += 1
        end
        numFilled = sum(envelopes .> 0)
        if numFilled == n
            fullCount += 1
        end
    end
    return fullCount/N
end

max_n = 100
N = 10^3

dataAnalytic2 = [occupancyAnalytic(big(n),big(2*n)) for n in 1:max_n]
dataAnalytic3 = [occupancyAnalytic(big(n),big(3*n)) for n in 1:max_n]
dataAnalytic4 = [occupancyAnalytic(big(n),big(4*n)) for n in 1:max_n]

dataMC2 = [occupancyMC(n,2*n,N) for n in 1:max_n]
dataMC3 = [occupancyMC(n,3*n,N) for n in 1:max_n]
dataMC4 = [occupancyMC(n,4*n,N) for n in 1:max_n]

plot(1:max_n,dataAnalytic2,"b",label="K=2")
plot(1:max_n,dataAnalytic3,"r",label="K=3")
plot(1:max_n,dataAnalytic4,"g",label="K=4")
plot(1:max_n,dataMC2,"k+")
plot(1:max_n,dataMC3,"k+")
plot(1:max_n,dataMC4,"k+")
xlim(0,max_n)
ylim(0,1)
xlabel("n")
ylabel("Probability")
legend(loc="upper right")
