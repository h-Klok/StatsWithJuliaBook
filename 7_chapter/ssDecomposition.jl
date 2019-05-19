using Random
Random.seed!(1)
x1Dat = rand(24)
x2Dat = rand(15)
x3Dat = rand(73)

allData = [x1Dat,x2Dat,x3Dat]
xBarArray = mean.(allData)
nArray = length.(allData)
xBarTotal = mean(vcat(allData...))
L = length(nArray)

ssBetween =
	sum([nArray[i]*(xBarArray[i] - xBarTotal)^2 for i in 1:L])
ssWithin =
	sum([sum([(ob - xBarArray[i])^2 for ob in allData[i]]) for i in 1:L])
ssTotal =
	sum([sum([(ob - xBarTotal)^2 for ob in allData[i]]) for i in 1:L])

println("Sum of squares between groups: ", ssBetween)
println("Sum of squares within groups: ", ssWithin)
println("Sum of squares total: ", ssTotal)
