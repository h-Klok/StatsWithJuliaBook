using StatsBase, Distributions, Plots; pyplot()

binomialRV(n,p) = sum(rand(n) .< p)

p, n, N = 0.5, 10, 10^6

bDist = Binomial(n,p)
xGrid = 0:n
bPmf = [pdf(bDist,i) for i in xGrid]
data = [binomialRV(n,p) for _ in 1:N]
pmfEst = counts(data,0:n)/N

plot( xGrid, pmfEst, 
	line=:stem, marker=:circle, 
	c=:blue, ms=10, msw=0, lw=4, label="MC estimate")
plot!( xGrid, bPmf, 
	 line=:stem, marker=:xcross, c=:red, 
	 ms=6, msw=0, lw=2, label="PMF", xticks=(0:1:10),
	 ylims=(0,0.3), xlabel="x", ylabel="Probability")