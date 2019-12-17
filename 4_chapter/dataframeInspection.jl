using DataFrames, CSV
data = CSV.read("../data/purchaseData.csv", copycols = true)

println(size(data),"\n")
println(names(data),"\n")
println(first(data, 6),"\n")
println(describe(data),"\n")