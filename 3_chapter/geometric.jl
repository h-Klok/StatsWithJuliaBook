using StatsBase, Distributions, PyPlot

function rouletteSpin(p)
    d, spin = 1, rand()
    while true
        spin < (1-p)^d ? d += 1 : break
    end
    d
end

p, xGrid, N = 18/37, 1:7, 10^6

mcEstimate = counts([rouletteSpin(p) for _ in 1:N],xGrid)/N

gDist = Geometric(p)
gPmf = [pdf(gDist,i-1) for i in xGrid]

stem(xGrid,mcEstimate,label="MC estimate",basefmt="none")
plot(xGrid,gPmf,"rx",ms=8,label="Analytic Solution")
ylim(0,0.5)
xlabel(L"$x$")
ylabel(L"$\mathbb{P}(X=x)$")
legend(loc="upper right")
savefig("geometric.png")
