using StatsBase

data = readcsv("grades.csv")[1,:]

xbar = mean(data)
svar = var(data)
sdev = std(data)
minval = minimum(data)
maxval = maximum(data)
med = median(data)
per95 = percentile(data, 25) #ie quantile(x, p/100
q95 = quantile(data, 0.75)
intquartrng = iqr(data)

println("Sample Mean: $xbar")
println("Sample Variance: $svar")
println("Sample Stadnard Deviation: $sdev")
println("Minimum: $minval")
println("Maximum: $maxval")
println("Median: $med")
println("95th percentile: $per95") 
println("0.95 quartile: $q95")
println("Interquartile range: $intquartrng")

summarystats(data)
