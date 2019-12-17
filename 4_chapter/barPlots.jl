using CSV, CategoricalArrays, StatsPlots; pyplot()

df = CSV.read("../data/companyData.csv")
years = levels(df.Year)
data  = reshape(df.MarketCap, 5, 3)

p1 = groupedbar(years, data, bar_position=:stack)
p2 = groupedbar(years, data, bar_position=:dodge)
plot(p1, p2, bar_width=0.7, fill=[:blue :red :green], label=["A" "B" "C"], 
	ylims=(0,6), xlabel="Year", ylabel="Market Cap (MM)", 
	legend=:topleft, size=(800,400))
