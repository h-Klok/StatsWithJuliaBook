using Distributions, Plots, LaTeXStrings; pyplot()

prior(lam) = pdf(TriangularDist(0, 10, 3), lam)
data = [2,1,0,0,1,0,2,2,5,2,4,0,3,2,5,0]

like(lam) = *([pdf(Poisson(lam),x) for x in data]...)
posteriorUpToK(lam) = like(lam)*prior(lam)

delta = 10^-4.
lamRange = 0:delta:10
K = sum([posteriorUpToK(lam)*delta for lam in lamRange])
posterior(lam) = posteriorUpToK(lam)/K

bayesEstimate = sum([lam*posterior(lam)*delta for lam in lamRange])
println("Bayes estimate: ",bayesEstimate)

plot(lamRange, prior.(lamRange), 
	c=:blue, label="Prior distribution")
plot!(lamRange, posterior.(lamRange), 
	c=:red, label="Posterior distribution", 
	xlims=(0, 10), ylims=(0, 1.2),
	xlabel=L"\lambda",ylabel="Density")