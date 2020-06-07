using Distributions, Plots, LaTeXStrings, Random; pyplot()

function tStat(mu0,mu,sig,n)
    sample = rand(Normal(mu,sig),n)
    xBar   = mean(sample)
    s      = std(sample)
    (xBar-mu0) / (s/sqrt(n))
end

function powerEstimate(mu0,mu1,sig,n,alpha,N)
    Random.seed!(0)
    sampleH1 = [tStat(mu0,mu1,sig,n) for _ in 1:N]
    critVal  = quantile(TDist(n-1),1-alpha)
    sum(sampleH1 .> critVal)/N
end

mu0 = 20
sig = 5
alpha = 0.05
N = 10^4
rangeMu1 = 16:0.1:30
nList = [5,10,20,30]

powerCurves = [powerEstimate.(mu0,rangeMu1,sig,n,alpha,N) for n in nList]    

plot(rangeMu1,powerCurves[1],c=:blue, label="n = $(nList[1])")
plot!(rangeMu1,powerCurves[2],c=:red, label="n = $(nList[2])")
plot!(rangeMu1,powerCurves[3],c=:green, label="n = $(nList[3])")
plot!(rangeMu1,powerCurves[4],c=:purple, label="n = $(nList[4])", 
	xlabel= L"\mu", ylabel="Power", 
	xlims=(minimum(rangeMu1) ,maximum(rangeMu1)), ylims=(0,1))