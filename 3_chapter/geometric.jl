using StatsBase, Distributions, PyPlot

function rouletteSpins(p)
    x = 0
    while true
        x += 1
        if rand() < p
            return x
        end
    end
end

p, xGrid, N = 18/37, 1:7, 10^6

mcEstimate = counts([rouletteSpins(p) for _ in 1:N],xGrid)/N

gDist = Geometric(p)
gPmf = [pdf(gDist,x-1) for x in xGrid]

stem(xGrid,mcEstimate,label="MC estimate",basefmt="none")
plot(xGrid,gPmf,"rx",ms=8,label="PMF")
ylim(0,0.5)
xlabel("x")
ylabel("Probability")
legend(loc="upper right")
