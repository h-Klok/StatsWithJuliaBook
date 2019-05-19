using StatsPlots, CSV

data = CSV.read("companyData.csv")
x2 = reshape(data[4],5,3)
p1 =groupedbar(unique(data[:Year]), x2, bar_position=:stack, bar_width=0.7, 
	fill=[:blue :red :green], legend=:topleft, label=["A", "B", "C"], 
		xlabel="Year", ylabel="Total Turnover per year (MM)")
p2 =groupedbar(unique(data[:Year]), x2, bar_position=:dodge, bar_width=0.7, 
	fill=[:blue :red :green], legend=:topleft, label=["A", "B", "C"], 
		xlabel="Year", ylabel="Turnover (MM)")
plot(p1, p2, layout = 2)
