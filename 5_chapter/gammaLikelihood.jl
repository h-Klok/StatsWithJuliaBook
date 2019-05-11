using Random, Distributions, PyPlot
Random.seed!(0)

actualAlpha, actualLambda = 2,3
gammaDist = Gamma(actualAlpha,1/actualLambda)
n = 10^3
sample = rand(gammaDist, n)

alphaGrid = 1.5:0.01:2.5
lambdaGrid = 2:0.01:3.5

likelihood = [ prod([pdf(Gamma(a,1/l),v) for v in sample])
                        for a in alphaGrid, l in lambdaGrid]
plot_surface(lambdaGrid, alphaGrid, likelihood, rstride=1,
        cstride=1,linewidth=0, antialiased=false, cmap="coolwarm")
