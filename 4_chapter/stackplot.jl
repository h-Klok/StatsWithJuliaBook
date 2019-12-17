using CSV, CategoricalArrays, Plots; pyplot()

df = CSV.read("../data/companyData.csv")
mktCap = reshape(df.MarketCap, 5, 3)
years  = levels(df.Year)

areaplot(years, mktCap, 
	c=[:blue :red :green], labels=["A" "B" "C"],
	xlims=(minimum(years),maximum(years)), ylims=(0,6.5), 
	legend=:topleft, xlabel="Years", ylabel="MarketCap")