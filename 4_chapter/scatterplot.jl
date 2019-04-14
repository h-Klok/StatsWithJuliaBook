using DataFrames, CSV, PyPlot

df = CSV.read("companyData.csv")

for g in groupby(df, :Type)
	xVals = g.Dividend
	yVals = g.StockPrice
	mktCap = g.MarketCap
	maxYear = maximum(g.Year)

	scatter(xVals, yVals, mktCap*100, alpha=0.5)
	plot(xVals, yVals,label = "Company $(g.Type[1])")
	legend(loc="upper left")
	annotate("$maxYear", xy = (last(xVals), last(yVals)))
end
xlabel("Dividend (%)")
ylabel("StockPrice (\$)")
xlim(0,10)
ylim(0,10)
