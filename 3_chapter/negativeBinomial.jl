using StatsBase, Distributions, PyPlot

function rouletteGambler(p,r) # p = failure, r = wins
    d, winCount = 0, 0
    while winCount < r
        d +=1
        rand() > p ? winCount += 1 : continue
    end
    d
end

xGrid, pFailure, rWins, N = 0:16, 19/37, 4, 10^6 

mcEstimate = counts([rouletteGambler(pFailure, rWins) for _ in 1:N],xGrid+rWins)/N
negBinomDist = NegativeBinomial(rWins, 1-pFailure)
negBinomPdf =  pdf(negBinomDist,xGrid)

stem(xGrid,mcEstimate,label="MC estimate",basefmt="none")
plot(xGrid,negBinomPdf,"rx",ms=8,label="Analytic Solution")
ylim(0,0.2)
xlabel(L"$x$")
ylabel("Probability")
legend(loc="upper right")
savefig("negativeBinomial.png")
