include("dataframeCreation.jl")

using DataFramesMeta
@where(dropmissing(purchaseData), :Price .> 10000, :Type .== "A")

grouped = groupby(dropmissing(purchaseData), :Type)
@based_on(grouped, avgPrice = mean(:Price))
