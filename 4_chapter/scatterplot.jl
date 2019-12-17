using DataFrames, CSV, Plots; pyplot()

df = CSV.read("../data/companyData.csv")
dividends = reshape(df[:Dividend], (5,:))
stkPrice  = reshape(df[:StockPrice], (5,:))

plot(dividends, stkPrice, 
	color=[:blue :red :green], xlims=(0,10), ylims=(0,10), 
	label=levels(df[:Type]), legend=:topleft, 
	xlabel="Dividend (%)", ylabel="StockPrice (\$)")
