using StatsBase, Distributions, PyPlot

function coinFlip(p,flips,N)
    counts([count(rand(flips) .< p) for _ in 1:N])/N
end

p, flips, N = 0.5, 10, 10^6

bDist = Binomial(flips,p)
xGrid = 0:flips
bPmf = [pdf(bDist,i) for i in xGrid]

stem(xGrid,coinFlip(p,flips,N),label="MC estimate",basefmt="none")
plot(xGrid,bPmf,"rx",ms=8,label="Analytic Solution")
ylim(0,0.3)
xlabel(L"$x$")
ylabel(L"$\mathbb{P}(X=x)$")
legend(loc="upper right")
savefig("binomialCoinFlip.png")
