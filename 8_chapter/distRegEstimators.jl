using DataFrames, GLM, PyPlot, Distributions, LinearAlgebra

beta0, beta1 = 2.0, 1.5
sigma = 2.5
n, N = 10, 10^4

function coefEst()
    xVals = collect(1:n)
    yVals = beta0 .+ beta1*xVals + rand(Normal(0,sigma),n)
    data = DataFrame([xVals,yVals],[:X,:Y])
    model = lm(@formula(Y ~ X), data)
    coef(model)
end

ests = [coefEst() for _ in 1:N]

plot(first.(ests),last.(ests),".b",ms="0.5")
plot(beta0,beta1,".r")

xBar = mean(1:n)
sXX = sum([(x - xBar)^2 for x in 1:n])
sx2 = sum([x^2 for x in 1:n])
var0 = sigma^2 * sx2/(n*sXX)
var1 = sigma^2/sXX
cv = -sigma^2*xBar/sXX

mu = [beta0, beta1]
Sigma = [var0 cv; cv var1]

r = 2.0
A = cholesky(Sigma).L
pts = [r*A*[cos(t),sin(t)] + mu  for t in 0:0.01:2pi]

plot(first.(pts),last.(pts),"r")
xlabel("beta0")
ylabel("beta1")
