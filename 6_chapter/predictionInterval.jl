using Random, Statistics, Distributions, PyPlot
Random.seed!(3)

mu, sig = 50, 3
dist = Normal(mu,sig)
alpha = 0.01
N = 40

observations = rand(dist,2)
ciLarray, ciUarray = [],[]

for n in 2:N
    xbar = mean(observations)
    sd = std(observations)
    tVal = quantile(TDist(n-1),1-alpha/2)
    delta = tVal * sd * sqrt(1+1/n)

    ciL = xbar - delta
    ciU = xbar + delta

    push!(ciLarray,ciL)
    push!(ciUarray,ciU)

    xNew = rand(dist)
    push!(observations,xNew)
end

plot(1:N+1,observations,".",label="Observations")
plot(3:N+1,ciUarray,"rx",label="Prediction Interval")
plot(3:N+1,ciLarray,"rx")
ylim(0,100)
xlabel("Number of observations")
ylabel("Value")
legend(loc="upper right")
