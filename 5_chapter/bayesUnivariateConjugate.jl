using Distributions, PyPlot

alpha, beta = 8, 2
prior(lam) = pdf(Gamma(alpha, 1/beta), lam)
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

newAlpha, newBeta = alpha + sum(data), beta + length(data)
closedFormBayesEstimate = mean(Gamma(newAlpha, 1/newBeta))

println("Computational Bayes Estimate: ", bayesEstimate)
println("Closed form Bayes Estimate: ", closedFormBayesEstimate)