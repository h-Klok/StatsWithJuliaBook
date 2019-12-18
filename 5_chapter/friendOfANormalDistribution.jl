using Distributions, Plots; pyplot()

mu, sigma = 10, 4
n, N = 10, 10^6

sMeans = Array{Float64}(undef, N)
sVars  = Array{Float64}(undef, N)
tStats = Array{Float64}(undef, N)

for i in 1:N
    data       = rand(Normal(mu,sigma),n)
    sampleMean = mean(data)
    sampleVars = var(data)
    sMeans[i]  = sampleMean
    sVars[i]   = sampleVars
    tStats[i]  = (sampleMean - mu)/(sqrt(sampleVars/n))
end

xRangeMean = 5:0.1:15
xRangeVar = 0:0.1:60
xRangeTStat = -5:0.1:5

p1 = stephist(sMeans, bins=50, c=:blue, normed=true, legend=false)
p1 = plot!(xRangeMean, pdf.(Normal(mu,sigma/sqrt(n)), xRangeMean),
    c=:red, xlims=(5,15), ylims=(0,0.35), xlabel="Sample mean",ylabel="Density")

p2 = stephist(sVars, bins=50, c=:blue, normed=true, label="Simulated")
p2 = plot!(xRangeVar, (n-1)/sigma^2*pdf.(Chisq(n-1), xRangeVar*(n-1)/sigma^2),
    c=:red, label="Analytic", xlims=(0,60), ylims=(0,0.06),
    xlabel="Sample Variance",ylabel="Density")

p3 = stephist(tStats, bins=100, c=:blue, normed=true, legend=false)
p3 = plot!(xRangeTStat, pdf.(TDist(n-1), xRangeTStat), 
    c=:red, xlims=(-5,5), ylims=(0,0.4), xlabel="t-statistic",ylabel="Density")

plot(p1, p2, p3, layout = (1,3), size=(1200, 400))
