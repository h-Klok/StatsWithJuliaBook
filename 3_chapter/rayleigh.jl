using Distributions, Random
Random.seed!(1)

N = 10^6
sig = 1.7

data1 = sqrt.(-(2* sig^2)*log.(rand(N)))

distG = Normal(0,sig)
data2 = sqrt.(rand(distG,N).^2 + rand(distG,N).^2)

distR = Rayleigh(sig)
data3 = rand(distR,N)

mean.([data1, data2, data3])