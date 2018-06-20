using Combinatorics, DataFrames

data = readtable("fertilizer.csv")
control = data[1]
fertilizer = data[2]

x = collect(combinations([control;fertilizer],10))

meanFert = mean(fertilizer)
proportion = sum([mean(i) >= meanFert for i in x])/length(x)
