using Statistics, StatsBase

data = parse.(Int, readlines("grades.csv"))

xbar = mean(data)
svar = var(data)
sdev = std(data)
minval = minimum(data)
maxval = maximum(data)
med = median(data)
per95 = percentile(data, 95)
q95 = quantile(data, 0.95)
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
