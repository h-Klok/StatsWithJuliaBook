using SpecialFunctions, Distributions, Roots, PyPlot

eq(alpha, xb, xbl) = log.(alpha) - digamma.(alpha) - log(xb) + xbl

actualAlpha, actualLambda = 2, 3
gammaDist = Gamma(actualAlpha,1/actualLambda)

function mle(sample)
    alpha  = find_zero( (a)->eq(a,mean(sample),mean(log.(sample))), 1)
    lambda = alpha/mean(sample)
    return [alpha,lambda]
end

N = 10^4

mles10   = [mle(rand(gammaDist,10)) for _ in 1:N]
mles100  = [mle(rand(gammaDist,100)) for _ in 1:N]
mles1000 = [mle(rand(gammaDist,1000)) for _ in 1:N]

plot(first.(mles10),last.(mles10),"b.",ms="0.3",label="n = 10")
plot(first.(mles100),last.(mles100),"r.",ms="0.3",label="n = 100")
plot(first.(mles1000),last.(mles1000),"g.",ms="0.3",label="n = 1000")
xlabel(L"$\alpha$")
ylabel(L"$\lambda$")
xlim(0,8)
ylim(0,8)
legend(markerscale=20,loc="upper right")
