using StatsBase, Distributions, PyPlot

function binomialRV(n,p)
   return sum(rand(n) .< p)
end

p, n, N = 0.5, 10, 10^6

bDist = Binomial(n,p)
xGrid = 0:n
bPmf = [pdf(bDist,i) for i in xGrid]
data = [binomialRV(n,p) for _ in 1:N]
pmfEst = counts(data,0:n)/N

stem(xGrid,pmfEst,label="MC estimate",basefmt="none")
plot(xGrid,bPmf,"rx",ms=8,label="PMF")
ylim(0,0.3)
xlabel("x")
ylabel("Probability")
legend(loc="upper right")
