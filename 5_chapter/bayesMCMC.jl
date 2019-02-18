using Distributions, PyPlot, KernelDensity

prior(lam) = pdf(TriangularDist(0, 10, 2), lam)
data = [3, 7, 0, 1, 5, 3, 6, 2]

likelihood(lam) = *([pdf(Poisson(lam),x) for x in data]...)
posteriorUpToK(lam) = likelihood(lam)*prior(lam)

function sampleFromPosterior(pf,N)#pseudo-density 
    #fill in code to generate a sample...
    #QQQQ Ref page around 230 in Dirk's book
    #replace this with returning N samples of pf
    return 8*rand(N)
end

N = 10^4
mcmcEstimates = sampleFromPosterior(posteriorUpToK,N)
kdePosterior = kde(mcmcEstimates)

delta = 10^-4.
lamRange = 0:delta:10

plot(lamRange, prior.(lamRange), "b")
plot(lamRange, pdf(kdePosterior,lamRange), "r")

bayesEstimate = mean(mcmcEstimates)