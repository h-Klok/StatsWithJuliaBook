using DataFrames

purchaseData = readtable("purchaseData.csv")
println(head(purchaseData))
println(showcols(purchaseData))
