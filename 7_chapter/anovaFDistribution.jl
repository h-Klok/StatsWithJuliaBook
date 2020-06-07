using Distributions, Plots; pyplot()

function anovaFStat(allData)
    xBarArray = mean.(allData)
    nArray = length.(allData)
    xBarTotal = mean(vcat(allData...))
    L = length(nArray)

    ssBetween = sum( [nArray[i]*(xBarArray[i] - xBarTotal)^2 for i in 1:L] )
    ssWithin = sum([sum([(ob - xBarArray[i])^2 for ob in allData[i]])
				for i in 1:L])
    return (ssBetween/(L-1))/(ssWithin/(sum(nArray)-L))
end

case1 = [13.4, 13.4, 13.4, 13.4, 13.4]
case2 = [12.7, 11.8, 13.4, 12.7, 12.9]
stdDevs = [2, 2, 2, 2, 2]
numObs = [24, 15, 13, 23, 9]
L = length(case1)

N = 10^5

mcFstatsH0 = Array{Float64}(undef, N)
for i in 1:N
    mcFstatsH0[i] = anovaFStat([ rand(Normal(case1[j],stdDevs[j]),numObs[j])
		for j in 1:L ])
end

mcFstatsH1 = Array{Float64}(undef, N)
for i in 1:N
    mcFstatsH1[i] = anovaFStat([ rand(Normal(case2[j],stdDevs[j]),numObs[j])
		for j in 1:L ])
end

stephist(mcFstatsH0, bins=100, 
	c=:blue, normed=true, label="Equal group means case")
stephist!(mcFstatsH1, bins=100, 
	c=:red, normed=true, label="Unequal group means case")

dfBetween = L - 1
dfError = sum(numObs) - 1
xGrid = 0:0.01:10
plot!(xGrid, pdf.(FDist(dfBetween, dfError),xGrid),
            c=:black, label="F-statistic analytic")
critVal = quantile(FDist(dfBetween, dfError),0.95)
plot!([critVal, critVal],[0,0.8], 
	c=:black, ls=:dash, label="Critical value boundary", 
	xlims=(0,10), ylims=(0,0.8), xlabel="F-value", ylabel="Density")