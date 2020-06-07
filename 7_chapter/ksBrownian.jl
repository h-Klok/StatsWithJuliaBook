using Random,Distributions,StatsBase,Plots,HypothesisTests,Measures; pyplot()
Random.seed!(3)

dist = Gamma(2, 2.5)
distH0 = Exponential(5)
n = 100
data = rand(dist,n)

Fhat = ecdf(data)
diffF(dist, x) = sqrt(n)*(Fhat(x) - cdf.(dist,x))
xGrid = 0:0.001:30
ksStat = maximum(abs.(diffF(distH0, xGrid)))

M = 10^5
KScdf(x) = sqrt(2pi)/x*sum([exp(-(2k-1)^2*pi^2 ./(8x.^2)) for k in 1:M])

println("p-value calculated via series: ",
	1-KScdf(ksStat))
println("p-value calculated via Kolmogorov distribution: ",
	1-cdf(Kolmogorov(),ksStat),"\n")

println(ApproximateOneSampleKSTest(data,distH0))

p1 = plot(xGrid, Fhat(xGrid), 
	c=:black, lw=1, label="ECDF from data")
p1 = plot!(xGrid, cdf.(dist,xGrid), 
	c=:blue, ls=:dot, label="CDF under \n actual distribution")
p1 = plot!(xGrid, cdf.(distH0,xGrid), 
	c=:red, ls=:dot, label="CDF under \n postulated H0", 
	xlims=(0,20), ylims=(0,1), xlabel = "x", ylabel = "Probability")

p2= plot(cdf.(dist,xGrid), diffF(dist, xGrid),lw=0.5, 
	c=:blue,	label="KS Process under \n actual distribution")
p2 = plot!(cdf.(distH0,xGrid), diffF(distH0, xGrid), lw=0.5, 
	c=:red, xlims=(0,1), label="KS Process under \n postulated H0",
    xlabel = "t", ylabel = "K-S Process")

plot(p1, p2, legend=:bottomright, size=(800, 400), margin = 5mm)