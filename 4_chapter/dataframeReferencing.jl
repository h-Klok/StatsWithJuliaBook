include("dataframeCreation.jl")
println(purchaseData[13:17,.Name])
println(purchaseData.Name[13:17])
purchaseData[ismissing.(purchaseData.Time), :]
filter(row-> ismissing(row.Time), purchaseData)
