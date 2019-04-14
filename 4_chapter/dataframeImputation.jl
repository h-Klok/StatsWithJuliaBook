using Random, Statistics
Random.seed!(0)
include("dataframeCreation.jl")

filter!(purchaseData) do row
    !(ismissing(row.Type) && ismissing(row.Price))
end

replace!(purchaseData.Name, missing=>"notRecorded")
replace!(purchaseData.Time, missing=>"12:00 PM")

types = unique(skipmissing(purchaseData.Type))
replace!(x -> ismissing(x) ? rand(types) : x, purchaseData.Type)

for g in groupby(purchaseData, :Type)
	prices = skipmissing(g.Price)
	isempty(prices) || replace!(g.Price, missing=>round(Int, mean(prices)))
end

CSV.write("purchaseDataImputed.csv", purchaseData)
describe(purchaseData)
