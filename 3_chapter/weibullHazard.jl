using Distributions, Plots, LaTeXStrings; pyplot()

alphas = [0.5, 1.5, 1]
lam = 2

lambda(dist::Weibull) = shape(dist)*scale(dist)^(-shape(dist))
theta(lam,alpha) = (alpha/lam)^(1/alpha)

dists = [Weibull.(a,theta(lam,a)) for a in alphas]

hA(dist,x) = pdf(dist,x)/ccdf(dist,x)
hB(dist,x) = lambda(dist)*x^(shape(dist)-1)

xGrid = 0.01:0.01:10
hazardsA = [hA.(d,xGrid) for d in dists]
hazardsB = [hB.(d,xGrid) for d in dists]

println("Maximum difference between two implementations of hazard: ", 
    maximum(maximum.(hazardsA-hazardsB)))

Cl = [:blue :red :green]
Lb = [L"\lambda=" * string(lambda(d)) * ",   " * L"\alpha =" * string(shape(d)) 
        for d in dists]

plot(xGrid, hazardsA, c=Cl, label=reshape(Lb, 1,:), xlabel="x",
	ylabel="Instantaneous failure rate", xlims=(0,10), ylims=(0,10))