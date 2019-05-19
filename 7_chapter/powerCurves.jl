using Distributions, KernelDensity, PyPlot

function tStat(mu0,mu,sig,n)
    sample = rand(Normal(mu,sig),n)
    xBar   = mean(sample)
    s      = std(sample)
    (xBar-mu0) / (s/sqrt(n))
end

function powerEstimate(mu0,mu1,sig,n,alpha,N)
    sampleH1 = [tStat(mu0,mu1,sig,n) for _ in 1:N]
    critVal  = quantile(TDist(n-1),1-alpha)
    sum(sampleH1 .> critVal)/N
end

mu0 = 20
sig = 5
alpha = 0.05
N = 10^5
rangeMu1 = 16:0.1:30

powersN05 = [powerEstimate(mu0,mu1,sig,5,alpha,N) for mu1 in rangeMu1]
powersN10 = [powerEstimate(mu0,mu1,sig,10,alpha,N) for mu1 in rangeMu1]
powersN20 = [powerEstimate(mu0,mu1,sig,20,alpha,N) for mu1 in rangeMu1]
powersN30 = [powerEstimate(mu0,mu1,sig,30,alpha,N) for mu1 in rangeMu1]

plot(rangeMu1,powersN05, "b", label="n = 5")
plot(rangeMu1,powersN10, "r", label="n = 10")
plot(rangeMu1,powersN20, "g", label="n = 20")
plot(rangeMu1,powersN30, "m", label="n = 30")
xlim(minimum(rangeMu1) ,maximum(rangeMu1))
ylim(0,1)
legend()
xlabel("mu")
ylabel("Power")
