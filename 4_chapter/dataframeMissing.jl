using Statistics

include("dataframeCreation.jl")
println(mean(purchaseData.Price))
println(mean(dropmissing(purchaseData).Price))
println(mean(skipmissing(purchaseData.Price)))
