using Distributions, PyPlot

prior(lam) = pdf(TriangularDist(0, 10, 2), lam)
data = [3, 7, 0, 1, 5, 3, 6, 2]

likelihood(lam) = *([pdf(Poisson(lam),x) for x in data]...)
posteriorUpToK(lam) = likelihood(lam)*prior(lam)

delta = 10^-4.
lamRange = 0:delta:10
K = sum([posteriorUpToK(lam)*delta for lam in lamRange])
posterior(lam) = posteriorUpToK(lam)/K

plot(lamRange, prior.(lamRange), "b")
plot(lamRange, posterior.(lamRange), "r")
bayesEstimate = sum([lam*posterior(lam)*delta for lam in lamRange])