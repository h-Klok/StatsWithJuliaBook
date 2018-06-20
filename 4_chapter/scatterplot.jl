using DataFrames, PyPlot

df = readtable("companyData.csv")

types = unique(df[:Type])

for t in types
	xVals = df[df[:Type] .== t, :Dividend]
	yVals = df[df[:Type] .== t, :StockPrice]
	mktCap = df[df[:Type] .== t, :MarketCap]
	maxYear = maximum(df[df[:Type] .== t, :Year])

	scatter(xVals, yVals, mktCap*100, alpha=0.5)
	plot(xVals,yVals,label = "Company $t")
	legend(loc="upper left")
	annotate("$maxYear", xy = (last(xVals),last(yVals)))
end
xlabel("Dividend (%)")
ylabel("StockPrice (\$)")
xlim(0,10)
ylim(0,10)
