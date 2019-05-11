using StatsBase, Distributions, PyPlot

function rouletteSpins(r,p)
    x = 0
    wins = 0
    while true
        x += 1
        if rand() < p
            wins += 1
            if wins == r
                return x
            end
        end
    end
end

r, p, N = 5, 18/37,10^6
xGrid = r:r+15

mcEstimate = counts([rouletteSpins(r,p) for _ in 1:N],xGrid)/N

nbDist = NegativeBinomial(r,p)
nbPmf = [pdf(nbDist,x-r) for x in xGrid]

stem(xGrid,mcEstimate,label="MC estimate",basefmt="none")
plot(xGrid,nbPmf,"rx",ms=8,label="PMF")
xlim(0,maximum(xGrid))
ylim(0,0.2)
xlabel("x")
ylabel("Probability")
legend(loc="upper right")
