using StatsBase, Distributions, PyPlot

function prn(lambda)
    k, p = 0, 1
    while p > MathConstants.e^(-lambda)
        k += 1
        p *= rand()
    end
    return k-1
end

xGrid, lambda, N = 0:16, 5.5, 10^6

pDist = Poisson(lambda)
bPmf = pdf(pDist,xGrid)
data = counts([prn(lambda) for _ in 1:N],xGrid)/N

stem(xGrid,data,label="MC estimate",basefmt="none")
plot(xGrid,bPmf,"rx",ms=8,label="PMF")
ylim(0,0.2)
xlabel(L"$k$")
ylabel(L"$\mathbb{P}(k$ events)")
legend(loc="upper right")
