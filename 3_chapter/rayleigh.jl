using Distributions

N = 10^6
sig = 1.7
distR = Rayleigh(sig)
distG = Normal(0,sig)

data1 = sqrt.(-(2* sig^2)*log.(rand(N)))
data2 = rand(distR,N)
data3 = sqrt.(rand(distG,N).^2 + rand(distG,N).^2)

mean.([data1, data2, data3])