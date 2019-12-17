using Distributions, Plots; pyplot()

L, K, n  = 500, [450, 400, 250, 100, 50], 30
hyperDists = [Hypergeometric(k,L-k,n) for k in K]
xGrid = 0:1:n
pmfs = [ pdf.(dist, xGrid) for dist in hyperDists ]
labels = "Successes = " .* string.(K)

bar( xGrid, pmfs, 
	alpha=0.8, c=[:orange :purple :green :red :blue ],
	label=hcat(labels...), ylims=(0,0.25),
	xlabel="x", ylabel="Probability", legend=:top)