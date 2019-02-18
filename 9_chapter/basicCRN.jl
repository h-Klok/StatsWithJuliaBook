using Distributions, PyPlot, Random

seed = 1
n = 10
lamGrid = 0.01:0.01:0.99

theorM(lam) = mean(Uniform(0,2*lam*(1-lam)))
estM(lam) = mean(rand(Uniform(0,2*lam*(1-lam)),n))

function estM(lam,seed)
    Random.seed!(seed)
    estM(lam)
end

trueM = theorM.(lamGrid)
estM0 = estM.(lamGrid)
estMCRN = estM.(lamGrid,seed) 

plot(lamGrid,trueM,"g")
plot(lamGrid,estM0,"r")
plot(lamGrid,estMCRN,"b");