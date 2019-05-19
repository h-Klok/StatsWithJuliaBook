using Random, Distributions, StatsBase, PyPlot, HypothesisTests
Random.seed!(2)

dist = Gamma(2, 2.5)
distH0 = Exponential(5)
n = 200
data = rand(dist,n)
Fhat = ecdf(data)
diffF(dist, x) = Fhat(x) - cdf(dist,x)
xGrid = 0:0.001:30

figure(figsize=(10,5))
subplot(121)
plot(xGrid,Fhat(xGrid),"k",lw=1, label="ECDF from data")
plot(xGrid,cdf(dist,xGrid),"b:",label="CDF under \n actual distribution")
plot(xGrid,cdf(distH0,xGrid),"r:",label="CDF under \n postulated H0")
legend(loc="lower right")
xlim(0,20);ylim(0,1)

subplot(122)
plot(cdf(dist,xGrid), diffF(dist, xGrid),lw=0.5, "b",
	label="KS Process under \n actual distribution")
plot(cdf(distH0,xGrid), diffF(distH0, xGrid),lw=0.5, "r",
	label="KS Process under \n postulated H0")
legend(loc="lower right")
xlim(0,1)

N = 10^5
KScdf(x) = sqrt(2pi)/x*sum([exp(-(2k-1)^2*pi^2 ./(8x.^2)) for k in 1:N])
ksStat = maximum(abs.(diffF(distH0, xGrid)))

println("p-value calculated via series: ",
	1-KScdf(sqrt(n)*ksStat))
println("p-value calculated via Kolmogorov distribution: ",
	1-cdf(Kolmogorov(),sqrt(n)*ksStat),"\n")

println(ApproximateOneSampleKSTest(data,distH0))
