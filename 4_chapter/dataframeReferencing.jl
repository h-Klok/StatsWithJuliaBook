using DataFrames, CSV
data = CSV.read("../data/purchaseData.csv", copycols = true)

println("Grade of person 1: ", data[1, 3], 
        ", ", data[1,:Grade], 
        ", ", data.Grade[1], "\n")
println(data[[1,2,4], :], "\n")
println(data[13:15, :Name], "\n")
println(data.Name[13:15], "\n")
println(data[13:15, [:Name]])