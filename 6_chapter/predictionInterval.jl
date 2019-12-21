using Random, Statistics, Distributions, Plots; pyplot()
Random.seed!(0)

mu, sig = 50, 5
dist = Normal(mu, sig)
alpha = 0.01
nMax = 40

observations = rand(dist,1)
piLarray, piUarray = [], []

for _ in 2:nMax
    xNew = rand(dist)
    push!(observations,xNew)

    xbar, sd = mean(observations), std(observations)
    n = length(observations)
    tVal = quantile(TDist(n-1),1-alpha/2)
    delta = tVal * sd * sqrt(1+1/n)
    piL, piU = xbar - delta, xbar + delta
    
    push!(piLarray,piL); push!(piUarray,piU)
end

scatter(1:nMax, observations, 
	c=:blue, msw=0, label="Observations")
plot!(2:nMax, piUarray, 
	c=:red, shape=:xcross, msw=0, label="Prediction Interval")
plot!(2:nMax, piLarray, 
	c=:red, shape=:xcross, msw=0, label="", 
	ylims=(0,100), xlabel="Number of observations", ylabel="Value")