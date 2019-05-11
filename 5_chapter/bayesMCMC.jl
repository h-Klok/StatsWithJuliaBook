using Distributions, PyPlot

alpha, beta = 8, 2
prior(lam) = pdf(Gamma(alpha, 1/beta), lam)
data = [3, 7, 0, 1, 5, 3, 6, 2]

likelihood(lam) = *([pdf(Poisson(lam),x) for x in data]...)
posteriorUpToK(lam) = likelihood(lam)*prior(lam)

sig = 0.5
foldedNormalPDF(x,mu) = (1/sqrt(2*pi*sig^2))*(exp(-(x-mu)^2/2sig^2)
                                                + exp(-(x+mu)^2/2sig^2))
foldedNormalRV(mu) = abs(rand(Normal(mu,sig)))

function sampler(piProb,qProp,rvProp)
    lam = 1
    warmN, N = 10^5, 10^6
    samples = zeros(N-warmN)

    for t in 1:N
        while true
            lamTry = rvProp(lam)
            L = piProb(lamTry)/piProb(lam)
            H = min(1,L*qProp(lam,lamTry)/qProp(lamTry,lam))
            if rand() < H
                lam = lamTry
                if t > warmN
                    samples[t-warmN] = lam
                end
                break
            end
        end
    end
    return samples
end

mcmcSamples = sampler(posteriorUpToK,foldedNormalPDF,foldedNormalRV)
plt.hist(mcmcSamples,100,density=true, label="Histogram of MCMC samples")

lamRange = 0:0.01:10
plot(lamRange, prior.(lamRange), "b", label="Prior distribution")
closedFormPosterior(lam)=pdf(Gamma(alpha + sum(data),1/(beta+length(data))),lam)
plot(lamRange, closedFormPosterior.(lamRange), "r", label="Posterior distribution")
xlim(0, 10); ylim(0, 0.7); legend(loc="upper right")
println("MCMC Bayes Estimate: ",mean(mcmcSamples))
