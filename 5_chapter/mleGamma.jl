using SpecialFunctions, Distributions, Roots, Plots, LaTeXStrings; pyplot()

eq(alpha, xb, xbl) = log(alpha) - digamma(alpha) - log(xb) + xbl

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

scatter(first.(mles10), last.(mles10), 
	c=:blue, ms=1, msw=0, label="n = 10")
scatter!(first.(mles100), last.(mles100), 
	c=:red, ms=1, msw=0, label="n = 100")
scatter!(first.(mles1000), last.(mles1000), 
	c=:green, ms=1, msw=0, label="n = 1000", 
	xlims=(0,6), ylims=(0,8), xlabel=L"\alpha", ylabel=L"\lambda")