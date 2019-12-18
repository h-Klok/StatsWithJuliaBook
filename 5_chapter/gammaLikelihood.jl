using Random, Distributions, Plots, LaTeXStrings; pyplot()
Random.seed!(0)

actualAlpha, actualLambda = 2,3
gammaDist = Gamma(actualAlpha,1/actualLambda)
n = 10^2
sample = rand(gammaDist, n)

alphaGrid = 1:0.02:3
lambdaGrid = 2:0.02:5

likelihood = [prod([pdf.(Gamma(a,1/l),v) for v in sample])
                        for l in lambdaGrid, a in alphaGrid]
                        
surface(alphaGrid, lambdaGrid, likelihood, lw=0.1, 
	c=cgrad([:blue, :red]), legend=:none, camera = (135,20),
	xlabel=L"\alpha", ylabel=L"\lambda", zlabel="Likelihood")