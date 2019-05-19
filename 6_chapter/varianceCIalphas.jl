using Distributions, PyPlot

std, n, N = 3, 15, 10^4
alphaUsed = 0.001:0.001:0.1
dNormal   = Normal(2,std)
dLogistic = Logistic(2,sqrt(std^2*3)/pi)

function alphaSimulator(dist, n, alpha)
    popVar        = var(dist)
    coverageCount = 0
    for i in 1:N
        sVar = var(rand(dist, n))
        L = (n - 1) * sVar / quantile(Chisq(n-1),1-alpha/2)
        U = (n - 1) * sVar / quantile(Chisq(n-1),alpha/2)
        coverageCount +=  L < popVar && popVar < U
    end
    1 - coverageCount/N
end

plot(alphaUsed, alphaSimulator.(dNormal,n,alphaUsed),".b",label="Normal")
plot(alphaUsed, alphaSimulator.(dLogistic, n, alphaUsed),".r",label="Logistic")
plot([0,0.1],[0,0.1],"k",lw=0.5)
xlabel("alpha used")
ylabel("alpha actual")
legend(loc="upper left")
xlim(0,0.1)
ylim(0,0.2)
