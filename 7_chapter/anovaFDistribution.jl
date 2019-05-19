using Random, Distributions, PyPlot
Random.seed!(808)

function anovaFStat(allData)
    xBarArray = mean.(allData)
    nArray = length.(allData)
    xBarTotal = mean(vcat(allData...))
    d = length(nArray)

    ssBetween = sum( [nArray[i]*(xBarArray[i] - xBarTotal)^2 for i in 1:d] )
    ssWithin = sum([sum([(ob - xBarArray[i])^2 for ob in allData[i]])
				for i in 1:d])
    return (ssBetween/(d-1))/(ssWithin/(sum(nArray)-d))
end

case1 = [13.4, 13.4, 13.4, 13.4, 13.4]
case2 = [12.7, 11.8, 13.4, 11.7, 12.9]
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

plt.hist(mcFstatsH0, 100, color="b", histtype="step",
                    normed="true", label="Equal group \nmeans case")
plt.hist(mcFstatsH1, 100, color="r", histtype="step",
                    normed="true", label="Unequal group \nmeans case")

dfBetween = L - 1
dfError = sum(numObs) - 1
xGrid = 0:0.01:10
plot(xGrid, pdf(FDist(dfBetween, dfError),xGrid),
            color="b", label="f-statistic \nanalytic")
critVal = quantile(FDist(dfBetween, dfError),0.95)
plot([critVal, critVal],[0,0.8],"k--", label="Critical value \nboundary")
xlim(0,10)
ylim(0,0.8)
xlabel("f-value")
legend(loc="upper right")
