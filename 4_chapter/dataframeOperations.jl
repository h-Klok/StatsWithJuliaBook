using DataFrames, CSV, Dates, Statistics
data = dropmissing(CSV.read("../data/purchaseData.csv", copycols=true))

data[!,:Date] = Date.(data[!,:Date], "d/m/y")
println(first(sort(data, :Date), 3),"\n")

println(first(filter(row -> row[:Price] > 50000, data),3 ),"\n")

categorical!(data, :Grade)
println(first(data, 3), "\n")

println(
   by(data, :Grade, :Price => 
       x -> ( NumSold=length(x), AvgPrice=mean(x)) )
   )