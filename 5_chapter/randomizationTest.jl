using Combinatorics, DataFrames, CSV

data = CSV.read("fertilizer.csv")
control = data.Control
fertilizer = data.FertilizerX

x = collect(combinations([control;fertilizer],10))

meanFert = mean(fertilizer)
proportion = sum([mean(i) >= meanFert for i in x])/length(x)
