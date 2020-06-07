using DataFrames, GLM, Distributions, LinearAlgebra, Random
using Plots, LaTeXStrings;pyplot()
Random.seed!(0)

beta0, beta1 = 2.0, 1.5
sigma = 2.5
n, N = 10, 10^4
alpha = 0.05

function coefEst()
    xVals = collect(1:n)
    yVals = beta0 .+ beta1*xVals + rand(Normal(0,sigma),n)
    data = DataFrame([xVals,yVals],[:X,:Y])
    model = lm(@formula(Y ~ X), data)
    coef(model)
end

ests = [coefEst() for _ in 1:N]

xBar = mean(1:n)
sXX = sum([(x - xBar)^2 for x in 1:n])
sx2 = sum([x^2 for x in 1:n])
var0 = sigma^2 * sx2/(n*sXX)
var1 = sigma^2/sXX
cv = -sigma^2*xBar/sXX

mu = [beta0, beta1]
Sigma = [var0 cv; cv var1]

A = cholesky(Sigma).L
Ai = inv(A)

r = quantile(Rayleigh(),1-alpha)
isInEllipse(x) = norm(Ai*(x-mu)) <= r
estIn = isInEllipse.(ests)

println("Proportion of points inside ellipse: ", sum(estIn)/N)

scatter(first.(ests[estIn]),last.(ests[estIn]),c=:green, ms=2, msw=0)
scatter!(first.(ests[.!estIn]),last.(ests[.!estIn]),c=:blue, ms=2, msw=0)

ellipsePts = [r*A*[cos(t),sin(t)] + mu  for t in 0:0.01:2pi]
scatter!([beta0],[beta1],c=:red, ms=5, msw = 0)
plot!(first.(ellipsePts),last.(ellipsePts), 
	c=:red, lw=2, legend=:none, 
	xlabel=L"\hat{\beta}_0", ylabel=L"\hat{\beta}_1")