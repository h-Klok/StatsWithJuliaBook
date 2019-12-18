using Distributions, Random, Statistics, Plots; pyplot()
Random.seed!(2)

n, N, alpha = 10, 10^7, 0.05
mActual = 0.75
dist0, dist1 = Uniform(0,1), Uniform(0,mActual)

ts(sample) = maximum(sample) - minimum(sample)

empiricalDistUnderH0 = [ts(rand(dist0,n)) for _ in 1:N]
rejectionValue = quantile(empiricalDistUnderH0,alpha)

sample = rand(dist1,n)
testStat = ts(sample)
pValue = sum(empiricalDistUnderH0 .<= testStat)/N

if testStat > rejectionValue
    print("Didn't reject: ", round(testStat,digits=4))
    print(" > ", round(rejectionValue,digits=4))
else
    print("Reject: ", round(testStat,digits=4))
    print(" <= ", round(rejectionValue,digits=4))
end
println("\np-value = $(round(pValue,digits=4))")

stephist(empiricalDistUnderH0, bins=100, c=:blue, normed=true, label="")
plot!([testStat, testStat], [0,4], c=:red, label="Observed test statistic")
plot!([rejectionValue, rejectionValue], [0,4], c=:black, ls=:dash,
	label="Critical value boundary", legend=:topleft, ylims=(0,4),
    	xlabel = "x", ylabel = "Density")