using Combinatorics, Statistics, DataFrames, CSV

data = CSV.read("../data/fertilizer.csv")
control = data.Control
fertilizer = data.FertilizerX

subGroups = collect(combinations([control;fertilizer],10))

meanFert = mean(fertilizer)
pVal = sum([mean(i) >= meanFert for i in subGroups])/length(subGroups)
println("p-value = ", pVal)