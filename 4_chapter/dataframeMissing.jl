using Statistics, DataFrames, CSV
data = CSV.read("../data/purchaseData.csv", copycols=true)

println(mean(data.Price),"\n")
println(mean(skipmissing(data.Price)),"\n")
println(coalesce.(data.Grade, "QQ")[1:4],"\n")
println(first(dropmissing(data,:Price), 4),"\n")
println(sum(ismissing.(data.Name)),"\n")
println(findall(completecases(data))[1:4])