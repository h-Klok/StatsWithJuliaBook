using StatsBase, Distributions, PyPlot

function prn(lamda)
    l, k, p = e^(-lambda), 0, 1
    while p > l
        k +=1
        p = p*rand()
    end
    return k-1
end

xGrid, lambda, N = 0:16, 5, 10^6

pDist = Poisson(lambda)
bPmf = pdf(pDist,xGrid)
data = counts([prn(lambda) for _ in 1:N],xGrid)/N

stem(xGrid,data,label="MC estimate",basefmt="none")
plot(xGrid,bPmf,"rx",ms=8,label="Analytic Solution")
ylim(0,0.2)
xlabel(L"$k$")
ylabel(L"$\mathbb{P}(k$ events)")
legend(loc="upper right")
savefig("poisson.png");
