using DataFrames, RDatasets, StatsBase
data = dataset("car","Davis")
htData = data[:Height]

fig = figure("KDE example", figsize=(8, 4))
ax = fig[:add_subplot](121)
plt[:hist](htData,50, histtype = "step")
ax = fig[:add_subplot](122)
boxplot(htData)
savefig("summaryStats.png")
summarystats(htData)